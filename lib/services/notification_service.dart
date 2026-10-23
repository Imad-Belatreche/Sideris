import 'dart:developer';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:isar_community/isar.dart';
import 'package:sideris/models/notification_rule/notification_rule_model.dart';
import 'package:sideris/models/scheduled_notification/schedule_model.dart';
import 'package:sideris/repositories/notifications_repository.dart';
import 'package:sideris/repositories/scheduled_notifications_repository.dart';
import 'package:sideris/utils/recurrence_calculator.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService({
    required NotificationsRepository notificationsRepository,
    FlutterLocalNotificationsPlugin? plugin,
    required SchedulesRepository schedulesRepository,
  }) : _schedulesRepository = schedulesRepository,
       _notificationsRepository = notificationsRepository,
       _plugin = plugin ?? FlutterLocalNotificationsPlugin();

  final NotificationsRepository _notificationsRepository;
  final SchedulesRepository _schedulesRepository;
  final FlutterLocalNotificationsPlugin _plugin;
  Future<void>? _syncInProgress;

  Future<void> initialize() async {
    await _plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  Future<bool> scheduleExactNotification(ScheduleModel schedule) async {
    if (!schedule.isPending ||
        schedule.consumedAt != null ||
        schedule.triggerTime.isBefore(DateTime.now()) ||
        schedule.cancelledAt != null) {
      throw Exception(
        "$runtimeType: Notification with id '${schedule.id}' doesn't have a triggerTime or it's in the past. Skipping scheduling.",
      );
    }
    try {
      final notificationRule = await _notificationsRepository
          .getNotificationById(schedule.ruleId);
      if (notificationRule == null) {
        throw Exception(
          "New notification did not found in db, this should not happen",
        );
      }
      await _plugin.zonedSchedule(
        id: schedule.platformId,
        notificationDetails: NotificationDetails(
          //TODO: Add IOS notification details
          android: AndroidNotificationDetails(
            notificationRule.bypassDnd
                ? 'sideris_dnd_channel_id'
                : 'sideris_channel_id',
            notificationRule.bypassDnd
                ? 'sideris_dnd_channel_name'
                : 'sideris_channel_name',
            channelBypassDnd: notificationRule.bypassDnd,
            importance: notificationRule.bypassDnd
                ? Importance.max
                : Importance.defaultImportance,
            priority: notificationRule.bypassDnd
                ? Priority.max
                : Priority.defaultPriority,
            enableVibration: true,

            colorized: notificationRule.colorTag != null ? true : false,
            color: notificationRule.colorTag?.value,

            //TODO: Add colored app icon based on notification

            //TODO: Add custom sound based on notification
          ),
        ),
        scheduledDate: tz.TZDateTime.from(schedule.triggerTime, tz.local),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

        title: notificationRule.title,
        body: notificationRule.content,
      );
      return true;
    } catch (e) {
      throw Exception("$runtimeType: Some error happened ${e.toString()}");
    }
  }

  Future<void> cancelNotification(int scheduleId) async {
    try {
      log("$runtimeType: Cancelling notification with id: $scheduleId");
      final canceledSchedule = await _schedulesRepository.getScheduleById(
        scheduleId,
      );
      if (canceledSchedule == null) {
        throw Exception("Notification not found");
      }

      await _plugin.cancel(id: canceledSchedule.platformId);
      await _schedulesRepository.markCancelled([
        canceledSchedule.id,
      ], DateTime.now());
    } catch (e) {
      throw Exception(
        "$runtimeType: Error cancelling notification with id: $scheduleId: $e",
      );
    }
  }

  Future<void> syncNotification() {
    final inProgress = _syncInProgress;
    if (inProgress != null) return inProgress;

    late final Future<void> operation;
    operation = _runSyncWithCleanup();
    _syncInProgress = operation;
    return operation;
  }

  Future<void> _runSyncWithCleanup() async {
    try {
      await _syncNotificationInternal();
    } finally {
      _clearSyncInProgress(_syncInProgress!);
    }
  }

  void _clearSyncInProgress(Future<void> operation) {
    if (identical(_syncInProgress, operation)) {
      _syncInProgress = null;
    }
  }

  Future<void> _syncNotificationInternal() async {
    final now = DateTime.now();
    await _reconcileOverdueSchedules(now);

    final groupedNearest600 = await _notificationsRepository
        .get600NotificationsToTrigger();
    final nearest600 = groupedNearest600.entries
        .where((entry) => !entry.key.isBefore(now))
        .expand(
          (entry) => entry.value.map(
            (rule) => (ruleId: rule.id, triggerTime: entry.key),
          ),
        )
        .toList();

    final systemPending = await _plugin.pendingNotificationRequests();
    final systemPendingIds = systemPending.map((request) => request.id).toSet();

    final localPending = (await _schedulesRepository.getPendingSchedules())
        .where(
          (schedule) =>
              schedule.status == ScheduleStatus.pending &&
              schedule.cancelledAt == null &&
              schedule.consumedAt == null,
        )
        .toList();

    final localByKey = <(int, DateTime), ScheduleModel>{};
    for (final schedule in localPending) {
      localByKey.putIfAbsent((
        schedule.ruleId,
        schedule.triggerTime,
      ), () => schedule);
    }

    final desiredSchedules = <ScheduleModel>[];
    final schedulesToInsert = <ScheduleModel>[];
    final desiredPlatformIds = <int>{};
    final desiredKeys = <(int, DateTime)>{};

    for (final candidate in nearest600) {
      final key = (candidate.ruleId, candidate.triggerTime);
      if (!desiredKeys.add(key)) continue;

      final schedule =
          localByKey[key] ??
          ScheduleModel(
            ruleId: candidate.ruleId,
            triggerTime: candidate.triggerTime,
          );

      desiredSchedules.add(schedule);
      if (schedule.id == Isar.autoIncrement) {
        schedulesToInsert.add(schedule);
      } else {
        desiredPlatformIds.add(schedule.platformId);
      }
    }

    if (schedulesToInsert.isNotEmpty) {
      await _schedulesRepository.addSchedules(schedulesToInsert);
      for (final schedule in schedulesToInsert) {
        desiredPlatformIds.add(schedule.platformId);
      }
    }

    final staleLocalSchedules = localPending.where((schedule) {
      final key = (schedule.ruleId, schedule.triggerTime);
      return !desiredKeys.contains(key);
    }).toList();
    if (staleLocalSchedules.isNotEmpty) {
      await _schedulesRepository.markCancelled(
        staleLocalSchedules.map((schedule) => schedule.id).toList(),
        now,
      );
    }

    final staleSystemIds = systemPendingIds.difference(desiredPlatformIds);
    for (final id in staleSystemIds) {
      await _plugin.cancel(id: id);
    }

    for (final schedule in desiredSchedules) {
      if (!systemPendingIds.contains(schedule.platformId)) {
        await scheduleExactNotification(schedule);
      }
    }
  }

  Future<void> _reconcileOverdueSchedules(DateTime now) async {
    final overdue = await _schedulesRepository.getOverduePendingSchedules(now);
    if (overdue.isEmpty) return;

    await _schedulesRepository.markConsumed(
      overdue.map((schedule) => schedule.id).toList(),
      now,
    );

    final overdueByRule = <int, List<ScheduleModel>>{};
    for (final schedule in overdue) {
      overdueByRule.putIfAbsent(schedule.ruleId, () => []).add(schedule);
    }

    for (final entry in overdueByRule.entries) {
      final rule = await _notificationsRepository.getNotificationById(
        entry.key,
      );
      if (rule == null) {
        await _schedulesRepository.deletePendingForRule(entry.key);
        continue;
      }

      final latestTrigger = entry.value
          .map((schedule) => schedule.triggerTime)
          .reduce((left, right) => left.isAfter(right) ? left : right);

      final remainingOccurrences = rule.totalOccurrences == null
          ? null
          : rule.totalOccurrences! - entry.value.length;

      final consumedRule = rule.copyWith(
        lastTriggeredAt: Optional(latestTrigger),
        totalOccurrences: Optional(remainingOccurrences),
      );

      await _schedulesRepository.deletePendingForRule(rule.id);

      if (!rule.isActive ||
          remainingOccurrences != null && remainingOccurrences <= 0) {
        await _notificationsRepository.updateNotification(
          consumedRule.copyWith(
            isActive: false,
            nextTriggersAt: Optional<List<DateTime>?>(null),
            nextTriggerAt: Optional<DateTime?>(null),
            updatedAt: Optional(now),
          ),
        );
        continue;
      }

      final nextTriggers = RecurrenceCalculator.computeNextTriggers(
        consumedRule,
        now: now,
      );

      if (nextTriggers.isEmpty ||
          (consumedRule.endDate != null &&
              nextTriggers.first.isAfter(consumedRule.endDate!))) {
        await _notificationsRepository.updateNotification(
          consumedRule.copyWith(
            isActive: false,
            nextTriggersAt: Optional<List<DateTime>?>(null),
            nextTriggerAt: Optional<DateTime?>(null),
            updatedAt: Optional(now),
          ),
        );
      } else {
        await _notificationsRepository.updateNotification(
          consumedRule.copyWith(
            isActive: true,
            nextTriggersAt: Optional(nextTriggers),
            nextTriggerAt: Optional(nextTriggers.first),
            updatedAt: Optional(now),
          ),
        );
      }
    }
  }
}

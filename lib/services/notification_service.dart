import 'dart:developer';

import 'package:sideris/models/notification_rule_model.dart';
import 'package:sideris/repositories/notifications_repository.dart';
import 'package:sideris/utils/recurrence_calculator.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  NotificationService._();
  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  final NotificationsRepository _notificationRepository =
      NotificationsRepository();

  int _platformId(int isarId) =>
      isarId.bitLength > 31 ? isarId % 0x7FFFFFFF : isarId;

  Future<void> initialize() async {
    await plugin.initialize(
      settings: const InitializationSettings(
        android: AndroidInitializationSettings('@mipmap/launcher_icon'),
        iOS: DarwinInitializationSettings(),
      ),
    );
  }

  //TODO: May create a separate permission service to handle all permission requests in the app
  Future<void> requestExactAlarmPermission() async {
    return plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestExactAlarmsPermission() ??
        Future.value();
  }

  Future<PermissionStatus> checkNotificationPermissionStatus() async {
    return Permission.notification.status;
  }

  Future<bool> scheduleExactNotification(
    NotificationRuleModel notificationRule,
  ) async {
    if (notificationRule.nextTriggerAt == null ||
        !notificationRule.nextTriggerAt!.isAfter(DateTime.now())) {
      throw Exception(
        "$runtimeType: Notification with id '${notificationRule.id}' doesn't have a nextTriggerAt or it's in the past. Skipping scheduling.",
      );
    }
    try {
      final isAlreadyScheduled = await plugin
          .pendingNotificationRequests()
          .then((scheduledNotifications) {
            return scheduledNotifications.any(
              (n) => n.id == _platformId(notificationRule.id),
            );
          });

      if (isAlreadyScheduled) {
        throw Exception(
          "$runtimeType: Notification with id '${notificationRule.id}' is already scheduled. Skipping scheduling.",
        );
      }

      await plugin.zonedSchedule(
        id: _platformId(notificationRule.id),
        notificationDetails: NotificationDetails(
          android: AndroidNotificationDetails(
            'sideris_channel_id',
            'sideris_channel_name',
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
        scheduledDate: tz.TZDateTime.from(
          notificationRule.nextTriggerAt!,
          tz.local,
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,

        title: notificationRule.title,
        body: notificationRule.content,
      );
      return true;
    } catch (e) {
      throw Exception("$runtimeType: Some error happened ${e.toString()}");
    }
  }

  Future<void> cancelNotification(int id) async {
    try {
      log("$runtimeType: Cancelling notification with id: $id");
      await plugin.cancel(id: _platformId(id));
    } catch (e) {
      throw Exception(
        "$runtimeType: Error cancelling notification with id: ${_platformId(id)}: $e",
      );
    }
  }

  Future<List<NotificationRuleModel>> refreshScheduledNotifications() async {
    try {
      final pendingOs = await plugin.pendingNotificationRequests();
      final pendingOsIds = pendingOs.map((n) => n.id).toSet();

      if (pendingOsIds.length > 50) {
        throw Exception(
          "$runtimeType: More than 50 notifications are scheduled. This should not happen.",
        );
      }

      var allActiveNotifications = await _notificationRepository
          .getActiveNotifications();

      for (var notification in allActiveNotifications) {
        if (notification.nextTriggerAt == null ||
            !notification.nextTriggerAt!.isAfter(DateTime.now())) {
          try {
            final response = RecurrenceCalculator.computeNextTrigger(
              notification,
            );

            if (response != null) {
              if (response.error != null) {
                log(
                  "$runtimeType: Error computing next trigger for notification with id: ${notification.id}. Error: ${response.error}",
                );
                notification = notification.copyWith(isActive: false);
                await _notificationRepository.updateNotification(notification);
              } else if (response.nextTrigger != null) {
                notification = notification.copyWith(
                  nextTriggerAt: Optional(response.nextTrigger),
                );
                await _notificationRepository.updateNotification(notification);
              }
            }
          } catch (e) {
            log(
              "$runtimeType: Error computing next trigger for notification with id: ${notification.id}. Error: $e",
            );
            notification = notification.copyWith(isActive: false);
            await _notificationRepository.updateNotification(notification);
          }
        }
      }

      allActiveNotifications = await _notificationRepository
          .getActiveNotifications();

      final candidates = allActiveNotifications.take(50).toList();
      final desiredIds = candidates.map((e) => _platformId(e.id)).toSet();

      for (var candidate in candidates) {
        final platformId = _platformId(candidate.id);
        if (!pendingOsIds.contains(platformId)) {
          try {
            await scheduleExactNotification(candidate);
            candidate = candidate.copyWith(isScheduled: true);
            await _notificationRepository.updateNotification(candidate);
          } catch (e) {
            log(
              "$runtimeType: Failed to schedule notification with id: ${candidate.id}. Error: $e",
            );
          }
        } else if (!candidate.isScheduled) {
          candidate = candidate.copyWith(isScheduled: true);
          await _notificationRepository.updateNotification(candidate);
        }
      }

      final forgottenIds = pendingOsIds.difference(desiredIds);
      for (final forgottenId in forgottenIds) {
        await cancelNotification(forgottenId);
        var rule = await _notificationRepository.getNotificationById(
          forgottenId,
        );
        if (rule != null) {
          rule = rule.copyWith(isScheduled: false);
          await _notificationRepository.updateNotification(rule);
        } else {
          log(
            "$runtimeType: Notification with id: $forgottenId is scheduled in OS but not found in database. This should not happen.",
          );
        }
      }

      return await _notificationRepository.getScheduledNotifications();
    } catch (e) {
      throw Exception(
        "$runtimeType: Error refreshing scheduled notifications: $e",
      );
    }
  }
}

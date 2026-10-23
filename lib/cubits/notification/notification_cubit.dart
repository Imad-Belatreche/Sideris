import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sideris/models/notification_rule/notification_rule_model.dart';
import 'package:sideris/repositories/notifications_repository.dart';
import 'package:sideris/repositories/scheduled_notifications_repository.dart';
import 'package:sideris/services/notification_service.dart';
import 'package:sideris/utils/exceptions.dart';
import 'package:sideris/utils/recurrence_calculator.dart';

part 'notification_state.dart';

//TODO: Implement the new ScheduledNotification model and update the cubit accordingly.
//The current implementation is based on the old NotificationRule model, which may not be compatible with the new ScheduledNotification model.
class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({
    required SchedulesRepository schedulesRepository,
    required NotificationsRepository notificationRepository,
    required NotificationService notificationService,
  }) : _notificationRepository = notificationRepository,
       _notificationService = notificationService,
       _schedulesRepository = schedulesRepository,
       super(NotificationState(notifications: []));

  final NotificationsRepository _notificationRepository;
  final NotificationService _notificationService;

  final SchedulesRepository _schedulesRepository;

  Future<void> loadNotifications() async {
    try {
      if (!state.isLoading) {
        emit(state.copyWith(isLoading: true, errorMessage: null));
      }
      await _notificationService.syncNotification();
      final notifications = await _notificationRepository.getAllNotifications();
      emit(state.copyWith(notifications: notifications));
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    } finally {
      emit(state.copyWith(isLoading: false));
    }
  }

  Future<NotificationRuleModel> addNotification(
    NotificationRuleModel notification,
  ) async {
    int? insertedId;

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      notification = notification.normalized();

      if (!notification.isForever &&
          notification.durationCount != null &&
          notification.durationUnit != null) {
        notification = notification.copyWith(
          endDate: Optional(
            RecurrenceCalculator.computeDurationEndDate(
              notification.startDate,
              notification.durationUnit,
              notification.durationCount,
            ),
          ),
        );
      }

      List<DateTime>? nextTriggers = RecurrenceCalculator.computeNextTriggers(
        notification,
      );

      if (nextTriggers.isNotEmpty) {
        notification = notification.copyWith(
          nextTriggersAt: Optional(nextTriggers),
          nextTriggerAt: Optional(nextTriggers.first),
          isActive: true,
        );
      } else {
        log(
          "NotificationCubit: Notification cannot be scheduled. Restoring as inactive.",
        );
        notification = notification.copyWith(
          isActive: false,
          nextTriggersAt: Optional<List<DateTime>?>(null),
          nextTriggerAt: Optional<DateTime?>(null),
        );
      }

      insertedId = await _notificationRepository.addNotification(notification);
      if (insertedId == -1) {
        throw NotificationException(
          "Failed to add notification to the database: $notification",
        );
      }
      log("Added notification id: $insertedId");

      final addedNotification = await _notificationRepository
          .getNotificationById(insertedId);

      if (addedNotification == null) {
        throw NotificationNotFoundException(
          "Failed to retrieve added notification with id: $insertedId",
        );
      }

      await loadNotifications();
      return addedNotification;
    } on NotificationException catch (e) {
      if (insertedId != null) {
        await _notificationRepository.deleteNotification(insertedId);
      }
      emit(state.copyWith(errorMessage: e.toString()));

      rethrow;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
      rethrow;
    } finally {
      if (state.isLoading) {
        emit(state.copyWith(isLoading: false));
        log(
          "NotificationCubit: Finished addNotification process. Error: ${state.errorMessage}",
        );
      }
    }
  }

  Future<void> updateNotification(NotificationRuleModel notification) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      notification = notification.normalized();

      if (!notification.isForever &&
          notification.durationCount != null &&
          notification.durationUnit != null) {
        notification = notification.copyWith(
          endDate: Optional(
            RecurrenceCalculator.computeDurationEndDate(
              notification.startDate,
              notification.durationUnit,
              notification.durationCount,
            ),
          ),
        );
      }

      List<DateTime> nextTriggers = RecurrenceCalculator.computeNextTriggers(
        notification,
      );
      if (nextTriggers.isNotEmpty) {
        notification = notification.copyWith(
          nextTriggersAt: Optional(nextTriggers),
          nextTriggerAt: Optional(nextTriggers.first),
          updatedAt: Optional(DateTime.now()),
        );

        await _schedulesRepository.deletePendingForRule(
          notification.id,
        );
        await _notificationRepository.updateNotification(notification);

        await loadNotifications();
      } else {
        log(
          "NotificationCubit: Notification cannot be scheduled. Restoring as inactive.",
        );
        notification = notification.copyWith(
          isActive: false,
          nextTriggersAt: Optional<List<DateTime>?>(null),
          nextTriggerAt: Optional<DateTime?>(null),
          updatedAt: Optional(DateTime.now()),
        );

        await _schedulesRepository.deletePendingForRule(
          notification.id,
        );
        await _notificationRepository.updateNotification(notification);

        await loadNotifications();
      }
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
    } finally {
      if (state.isLoading) {
        emit(state.copyWith(isLoading: false));
        log(
          "NotificationCubit: Finished updateNotification process. Error: ${state.errorMessage}",
        );
      }
    }
  }

  Future<NotificationRuleModel> deleteNotification(int id) async {
    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));
      final notification = await _notificationRepository.getNotificationById(
        id,
      );
      if (notification == null) {
        throw NotificationNotFoundException(
          "Notification not found for id: $id",
        );
      }

      await _notificationRepository.deleteNotification(id);

      await _schedulesRepository.deleteSchedulesOfRule(
        notification.id,
      );

      await loadNotifications();
      return notification;
    } catch (e) {
      emit(state.copyWith(errorMessage: e.toString()));
      rethrow;
    } finally {
      if (state.isLoading) {
        emit(state.copyWith(isLoading: false));
        log(
          "NotificationCubit: Finished deleteNotification process. Error: ${state.errorMessage}",
        );
      }
    }
  }
}

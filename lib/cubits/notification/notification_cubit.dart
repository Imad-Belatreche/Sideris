import 'dart:developer';

import 'package:sideris/models/notification_rule_model.dart';
import 'package:sideris/repositories/notifications_repository.dart';
import 'package:sideris/services/notification_service.dart';
import 'package:sideris/utils/exceptions.dart';
import 'package:sideris/utils/recurrence_calculator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit() : super(NotificationState(notifications: []));
  final _notificationRepository = NotificationsRepository();
  final _notificationService = NotificationService.instance;

  Future<void> loadNotifications() async {
    try {
      if (!state.isLoading) {
        emit(state.copyWith(isLoading: true, errorMessage: null));
      }
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

      final nextTrigger = RecurrenceCalculator.computeNextTrigger(notification);
      if (nextTrigger == null) {
        throw NotificationException(
          "Failed to compute next trigger for notification: $notification",
        );
      } else if (nextTrigger.error != null) {
        throw NotificationException(
          "Error computing next trigger for notification: $notification. Error: ${nextTrigger.error}",
        );
      }

      notification = notification.copyWith(
        nextTriggerAt: Optional(nextTrigger.nextTrigger),
      );

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

      await _notificationService.refreshScheduledNotifications();
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

      await _notificationRepository.updateNotification(notification);

      await _notificationService.refreshScheduledNotifications();
      await loadNotifications();
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

      await _notificationService.refreshScheduledNotifications();
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

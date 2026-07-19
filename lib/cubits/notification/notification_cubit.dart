import 'dart:developer';

import 'package:dakerni/models/notification_rule_model.dart';
import 'package:dakerni/repositories/notifications_repository.dart';
import 'package:dakerni/services/notification_service.dart';
import 'package:dakerni/utils/exceptions.dart';
import 'package:dakerni/utils/recurrence_calculator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';

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

  // inside e.g. NotificationSettingsCubit
  Future<void> ensureNotificationPermission(BuildContext context) async {
    final status = await NotificationService.instance
        .checkNotificationPermissionStatus();

    if (status.isPermanentlyDenied || status.isDenied) {
      if (!context.mounted) return;
      final shouldOpenSettings = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Notifications Permission Required'),
          content: const Text(
            'Please allow notifications permission in settings to receive reminders.',
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context, true),
              child: const Text('Open Settings'),
            ),
          ],
        ),
      );
      if (shouldOpenSettings == true) await openAppSettings();
    } else if (!status.isGranted) {
      await NotificationService.instance.requestExactAlarmPermission();
    }
  }

  Future<NotificationRuleModel> addNotification(
    NotificationRuleModel notification,
  ) async {
    int? insertedId;

    try {
      emit(state.copyWith(isLoading: true, errorMessage: null));

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

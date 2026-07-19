part of 'notification_cubit.dart';

final class NotificationState {
  final bool isLoading;
  final String? errorMessage;
  final List<NotificationRuleModel> notifications;

  NotificationState copyWith({
    List<NotificationRuleModel>? notifications,
    bool? isLoading,
    String? errorMessage,
  }) {
    return NotificationState(
      notifications: notifications ?? this.notifications,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  NotificationState({
    required this.notifications,
    this.isLoading = false,
    this.errorMessage,
  });
}

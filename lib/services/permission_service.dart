import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:permission_handler/permission_handler.dart';

class NotificationPermissionStatus {
  final bool isExactAlarmPermissionGranted;
  final bool isNotificationPermissionGranted;
  final bool isDndAccessPermissionGranted;

  const NotificationPermissionStatus({
    required this.isExactAlarmPermissionGranted,
    required this.isNotificationPermissionGranted,
    required this.isDndAccessPermissionGranted,
  });
}

class PermissionService {
  PermissionService._();
  static final PermissionService instance = PermissionService._();

  final FlutterLocalNotificationsPlugin plugin =
      FlutterLocalNotificationsPlugin();

  Future<NotificationPermissionStatus>
  checkNotificationPermissionStatus() async {
    final notificationStatus = await Permission.notification.status;
    final exactAlarmStatus = await Permission.scheduleExactAlarm.status;
    final dndStatus = await Permission.accessNotificationPolicy.status;

    return NotificationPermissionStatus(
      isExactAlarmPermissionGranted:
          exactAlarmStatus == PermissionStatus.granted,
      isNotificationPermissionGranted:
          notificationStatus == PermissionStatus.granted,
      isDndAccessPermissionGranted: dndStatus == PermissionStatus.granted,
    );
  }

  Future<void> requestExactAlarmPermission() async {
    return plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestExactAlarmsPermission() ??
        Future.value();
  }

  Future<void> requestNotificationPermission() async {
    return plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationsPermission() ??
        Future.value();
  }

  Future<void> requestDndAccessPermission() async {
    return plugin
            .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin
            >()
            ?.requestNotificationPolicyAccess() ??
        Future.value();
  }
}

import 'dart:developer';

import 'package:flutter/widgets.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:sideris/isar_setup.dart';
import 'package:sideris/repositories/notifications_repository.dart';
import 'package:sideris/repositories/scheduled_notifications_repository.dart';
import 'package:sideris/services/notification_service.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:workmanager/workmanager.dart';

const androidNotificationSyncTask = 'sideris-notification-sync';

@pragma('vm:entry-point')
void androidBackgroundCallbackDispatcher() {
  Workmanager().executeTask((task, inputData) async {
    WidgetsFlutterBinding.ensureInitialized();

    try {
      final timezone = await FlutterTimezone.getLocalTimezone();
      initializeTimeZones();
      tz.setLocalLocation(tz.getLocation(timezone.identifier));

      await initializeIsar();
      final notificationsRepository = NotificationsRepository(database: isar);
      final schedulesRepository = SchedulesRepository(database: isar);
      final notificationService = NotificationService(
        notificationsRepository: notificationsRepository,
        schedulesRepository: schedulesRepository,
      );

      await notificationService.initialize();
      await notificationService.syncNotification();
      return true;
    } catch (error, stackTrace) {
      log(
        'Android background notification sync failed',
        error: error,
        stackTrace: stackTrace,
      );
      return false;
    }
  });
}

Future<void> registerAndroidBackgroundSync() async {
  final workmanager = Workmanager();
  await workmanager.initialize(androidBackgroundCallbackDispatcher);
  await workmanager.registerPeriodicTask(
    androidNotificationSyncTask,
    androidNotificationSyncTask,
    frequency: const Duration(minutes: 15),
    constraints: Constraints(networkType: NetworkType.notRequired),
    existingWorkPolicy: ExistingPeriodicWorkPolicy.keep,
  );
}

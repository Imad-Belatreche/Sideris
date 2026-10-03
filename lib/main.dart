import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/app.dart';
import 'package:sideris/isar_setup.dart';
import 'package:sideris/repositories/notifications_repository.dart';
import 'package:sideris/repositories/settings_repository.dart';
import 'package:sideris/services/notification_service.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final TimezoneInfo currentTimeZone = await FlutterTimezone.getLocalTimezone();
  initializeTimeZones();
  tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));

  SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Colors.transparent,

      systemNavigationBarContrastEnforced: false,
      systemStatusBarContrastEnforced: false,

      systemNavigationBarIconBrightness: Brightness.dark,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  final settingsRepository = SettingsRepository();
  final initialSettings = await settingsRepository.loadSettings();

  await initializeIsar();
  final notificationRepository = NotificationsRepository(isar);
  final notificationService = NotificationService(
    repository: notificationRepository,
  );

  await notificationService.initialize();

  runApp(
    MyApp(
      settingsRepository: settingsRepository,
      notificationRepository: notificationRepository,
      notificationService: notificationService,
      initialSettings: initialSettings,
    ),
  );
}

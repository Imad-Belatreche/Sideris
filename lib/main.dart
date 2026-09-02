import 'package:sideris/app.dart';
import 'package:sideris/isar_setup.dart';
import 'package:sideris/services/notification_service.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter/services.dart';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:timezone/data/latest.dart';
import 'package:timezone/timezone.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final TimezoneInfo currentTimeZone = await FlutterTimezone.getLocalTimezone();
  initializeTimeZones();
  tz.setLocalLocation(tz.getLocation(currentTimeZone.identifier));

  await NotificationService.instance.initialize();

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

  await initializeIsar();

  runApp(const MyApp());
}

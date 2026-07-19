import 'package:dakerni/app.dart';
import 'package:dakerni/isar_setup.dart';
import 'package:dakerni/services/notification_service.dart';
import 'package:flutter/material.dart';
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

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  await initializeIsar();
  
  runApp(const MyApp());
}

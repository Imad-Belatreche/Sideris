import 'package:material_ui/material_ui.dart';
import 'package:timezone/timezone.dart' as tz;

bool isFutureDateTime(DateTime selectedDate, TimeOfDay selectedTime) {
  final now = DateTime.now();

  final finalDateTime = DateTime(
    selectedDate.year,
    selectedDate.month,
    selectedDate.day,
    selectedTime.hour,
    selectedTime.minute,
  );

  return finalDateTime.isAfter(now);
}

String formateDate(DateTime dateTime) {
  return "${dateTime.day}/${dateTime.month}/${dateTime.year}";
}

String formateTime(DateTime dateTime) {
  return "${dateTime.hour}:${dateTime.minute.toString().padLeft(2, '0')}";
}

tz.TZDateTime convertToTZDateTime(DateTime dateTime) {
  final location = tz.local;
  return tz.TZDateTime.from(dateTime, location);
}

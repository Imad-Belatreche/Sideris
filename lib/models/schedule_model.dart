import 'package:material_ui/material_ui.dart';
import 'package:timezone/timezone.dart' as tz;

class ScheduleModel {
  final DateTime? dateTime;
  final TimeOfDay? timeOfDay;

  ScheduleModel({this.dateTime, this.timeOfDay});

  ScheduleModel copyWith({DateTime? dateTime, TimeOfDay? timeOfDay}) {
    return ScheduleModel(
      dateTime: dateTime ?? this.dateTime,
      timeOfDay: timeOfDay ?? this.timeOfDay,
    );
  }

  tz.TZDateTime get scheduledDate {
    if (dateTime == null || timeOfDay == null) {
      return tz.TZDateTime(
        tz.local,
        DateTime.now().year,
        DateTime.now().month,
        DateTime.now().day,
        TimeOfDay.now().hour,
        TimeOfDay.now().minute,
      );
    }
    return tz.TZDateTime(
      tz.local,
      dateTime!.year,
      dateTime!.month,
      dateTime!.day,
      timeOfDay!.hour,
      timeOfDay!.minute,
    );
  }
}

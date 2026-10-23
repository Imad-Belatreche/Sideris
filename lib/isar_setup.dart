import 'package:isar_community/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sideris/models/notification_rule/notification_rule_model.dart';
import 'package:sideris/models/scheduled_notification/schedule_model.dart';

late final Isar isar;

Future<Isar> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open([
    NotificationRuleModelSchema,
    ScheduleModelSchema,
  ], directory: dir.path);
  return isar;
}

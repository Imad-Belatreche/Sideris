import 'package:sideris/models/notification_rule_model.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

late final Isar isar;

Future<Isar> initializeIsar() async {
  final dir = await getApplicationDocumentsDirectory();
  isar = await Isar.open([NotificationRuleModelSchema], directory: dir.path);
  return isar;
}

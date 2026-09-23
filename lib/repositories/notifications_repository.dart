import 'package:sideris/models/notification_rule_model.dart';
import 'package:isar/isar.dart';

class NotificationsRepository {
  final Isar database;

  NotificationsRepository(this.database);

  Future<int> addNotification(NotificationRuleModel notification) async {
    int id = -1;
    await database.writeTxn(() async {
      id = await database.notificationRuleModels.put(notification);
    });
    return id;
  }

  Future<void> updateNotification(NotificationRuleModel notification) async {
    await database.writeTxn(() async {
      await database.notificationRuleModels.put(notification);
    });
  }

  Future<void> deleteNotification(int id) async {
    await database.writeTxn(() async {
      await database.notificationRuleModels.delete(id);
    });
  }

  Future<List<NotificationRuleModel>> getAllNotifications() async {
    return await database.notificationRuleModels
        .where()
        .sortByNextTriggerAt()
        .findAll();
  }

  Future<NotificationRuleModel?> getNotificationById(int id) async {
    return await database.notificationRuleModels.get(id);
  }

  Future<List<NotificationRuleModel>> getActiveNotifications() async {
    return await database.notificationRuleModels
        .where()
        .isActiveEqualToAnyIsScheduledNextTriggerAt(true)
        .sortByNextTriggerAt()
        .findAll();
  }

  Future<List<NotificationRuleModel>> getNonActiveNotifications() async {
    return await database.notificationRuleModels
        .where()
        .isActiveEqualToAnyIsScheduledNextTriggerAt(false)
        .sortByNextTriggerAt()
        .findAll();
  }

  Future<List<NotificationRuleModel>> getScheduledNotifications() async {
    return await database.notificationRuleModels
        .where()
        .isActiveIsScheduledEqualToAnyNextTriggerAt(true, true)
        .sortByNextTriggerAt()
        .findAll();
  }

  Future<List<NotificationRuleModel>> get50NotificationsToTrigger() async {
    return await database.notificationRuleModels
        .where()
        .isActiveIsScheduledEqualToAnyNextTriggerAt(true, false)
        .sortByNextTriggerAt()
        .limit(50)
        .findAll();
  }
}

import 'package:dakerni/isar_setup.dart';
import 'package:dakerni/models/notification_rule_model.dart';
import 'package:isar/isar.dart';

class NotificationsRepository {
  Future<int> addNotification(NotificationRuleModel notification) async {
    int id = -1;
    await isar.writeTxn(() async {
      id = await isar.notificationRuleModels.put(notification);
    });
    return id;
  }

  Future<void> updateNotification(NotificationRuleModel notification) async {
    await isar.writeTxn(() async {
      await isar.notificationRuleModels.put(notification);
    });
  }

  Future<void> deleteNotification(int id) async {
    await isar.writeTxn(() async {
      await isar.notificationRuleModels.delete(id);
    });
  }

  Future<List<NotificationRuleModel>> getAllNotifications() async {
    return await isar.notificationRuleModels
        .where()
        .sortByNextTriggerAt()
        .findAll();
  }

  Future<NotificationRuleModel?> getNotificationById(int id) async {
    return await isar.notificationRuleModels.get(id);
  }

  Future<List<NotificationRuleModel>> getActiveNotifications() async {
    return await isar.notificationRuleModels
        .where()
        .isActiveEqualToAnyIsScheduledNextTriggerAt(true)
        .sortByNextTriggerAt()
        .findAll();
  }

  Future<List<NotificationRuleModel>> getNonActiveNotifications() async {
    return await isar.notificationRuleModels
        .where()
        .isActiveEqualToAnyIsScheduledNextTriggerAt(false)
        .sortByNextTriggerAt()
        .findAll();
  }

  Future<List<NotificationRuleModel>> getScheduledNotifications() async {
    return await isar.notificationRuleModels
        .where()
        .isActiveIsScheduledEqualToAnyNextTriggerAt(true, true)
        .sortByNextTriggerAt()
        .findAll();
  }

  Future<List<NotificationRuleModel>> get50NotificationsToTrigger() async {
    return await isar.notificationRuleModels
        .where()
        .isActiveIsScheduledEqualToAnyNextTriggerAt(true, false)
        .sortByNextTriggerAt()
        .limit(50)
        .findAll();
  }
}

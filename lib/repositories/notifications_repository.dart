import 'dart:collection';

import 'package:isar_community/isar.dart';
import 'package:sideris/models/notification_rule/notification_rule_model.dart';

class NotificationsRepository {
  final Isar _database;

  NotificationsRepository({required Isar database}) : _database = database;

  Future<int> addNotification(NotificationRuleModel notification) async {
    int id = -1;
    await _database.writeTxn(() async {
      id = await _database.notificationRuleModels.put(notification);
    });
    return id;
  }

  Future<void> updateNotification(NotificationRuleModel notification) async {
    await _database.writeTxn(() async {
      await _database.notificationRuleModels.put(notification);
    });
  }

  Future<void> deleteNotification(int id) async {
    await _database.writeTxn(() async {
      await _database.notificationRuleModels.delete(id);
    });
  }

  Future<List<NotificationRuleModel>> getAllNotifications() async {
    return await _database.notificationRuleModels
        .where()
        .sortByNextTriggerAt()
        .findAll();
  }

  Future<NotificationRuleModel?> getNotificationById(int id) async {
    return await _database.notificationRuleModels.get(id);
  }

  Future<List<NotificationRuleModel>> getActiveNotifications() async {
    return await _database.notificationRuleModels
        .where()
        .isActiveEqualTo(true)
        .sortByNextTriggerAt()
        .findAll();
  }

  Future<List<NotificationRuleModel>> getNonActiveNotifications() async {
    return await _database.notificationRuleModels
        .where()
        .isActiveEqualTo(false)
        .sortByLastTriggeredAt()
        .findAll();
  }

  Future<SplayTreeMap<DateTime, List<NotificationRuleModel>>>
  get600NotificationsToTrigger() async {
    final now = DateTime.now();
    final nearestPairs = SplayTreeMap<DateTime, List<NotificationRuleModel>>(
      (key1, key2) => key1.compareTo(key2),
    );

    final activeRules = await getActiveNotifications();

    for (var rule in activeRules) {
      if (rule.nextTriggersAt == null || rule.nextTriggersAt!.isEmpty) continue;

      final seenTriggers = <DateTime>{};
      for (var dateTime in rule.nextTriggersAt!) {
        if (dateTime.isBefore(now) || !seenTriggers.add(dateTime)) continue;
        nearestPairs.update(
          dateTime,
          (value) => value..add(rule),
          ifAbsent: () => [rule],
        );
      }
    }

    const maxNotifs = 600;
    int remaining = maxNotifs;

    final SplayTreeMap<DateTime, List<NotificationRuleModel>> nearest60 =
        SplayTreeMap<DateTime, List<NotificationRuleModel>>(
          (key1, key2) => key1.compareTo(key2),
        );
    for (var entery in nearestPairs.entries) {
      if (remaining == 0) break;

      final rulesAtTime = entery.value;
      final selectedCount = rulesAtTime.length <= remaining
          ? rulesAtTime.length
          : remaining;

      nearest60[entery.key] = rulesAtTime.take(selectedCount).toList();
      remaining -= selectedCount;
    }

    return nearest60;
  }
}

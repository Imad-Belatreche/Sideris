import 'package:isar_community/isar.dart';
import 'package:sideris/models/notification_rule/notification_rule_model.dart';
import 'package:sideris/models/scheduled_notification/schedule_model.dart';

//TODO: What if we add more attributes to ScheduleModel in the future to be able
//to delete a `NotificationRuleModel` while keeping its historical `ScheduleModel` records?
class SchedulesRepository {
  final Isar _database;

  const SchedulesRepository({required Isar database}) : _database = database;

  Future<List<int>> addSchedules(List<ScheduleModel> schedules) async {
    late List<Id> ids;
    await _database.writeTxn(() async {
      ids = await _database.scheduleModels.putAll(schedules);
    });

    return ids;
  }

  Future<ScheduleModel?> getScheduleById(int id) {
    return _database.scheduleModels.get(id);
  }

  Future<List<ScheduleModel?>> getSchedulesByIds(List<int> ids) {
    return _database.scheduleModels.getAll(ids);
  }

  Future<List<ScheduleModel>> getPendingSchedules() {
    return _database.scheduleModels
        .filter()
        .statusEqualTo(ScheduleStatus.pending)
        .consumedAtIsNull()
        .cancelledAtIsNull()
        .findAll();
  }

  Future<List<ScheduleModel>> getOverduePendingSchedules(DateTime now) {
    return _database.scheduleModels
        .filter()
        .statusEqualTo(ScheduleStatus.pending)
        .consumedAtIsNull()
        .cancelledAtIsNull()
        .triggerTimeLessThan(now)
        .sortByTriggerTime()
        .findAll();
  }

  Future<List<ScheduleModel>> getAllTriggeredSchedules() {
    return _database.scheduleModels
        .filter()
        .statusEqualTo(ScheduleStatus.consumed)
        .cancelledAtIsNull()
        .consumedAtIsNotNull()
        .sortByConsumedAtDesc()
        .findAll();
  }

  Future<List<ScheduleModel>> getAllSchedulesForRule(int ruleId) {
    return _database.scheduleModels
        .filter()
        .ruleIdEqualTo(ruleId)
        .sortByTriggerTime()
        .findAll();
  }

  Future<List<ScheduleModel>> deleteSchedulesOfRule(int ruleId) async {
    final schedules = await getAllSchedulesForRule(ruleId);

    await _database.writeTxn(() async {
      await _database.scheduleModels.deleteAll(
        schedules.map((schedule) => schedule.id).toList(),
      );
    });

    return schedules;
  }

  Future<List<ScheduleModel>> deletePendingForRule(int ruleId) async {
    final pendingForRule = await _database.scheduleModels
        .filter()
        .ruleIdEqualTo(ruleId)
        .statusEqualTo(ScheduleStatus.pending)
        .consumedAtIsNull()
        .cancelledAtIsNull()
        .findAll();

    await _database.writeTxn(() async {
      await _database.scheduleModels
          .filter()
          .ruleIdEqualTo(ruleId)
          .statusEqualTo(ScheduleStatus.pending)
          .consumedAtIsNull()
          .cancelledAtIsNull()
          .deleteAll();
    });

    return pendingForRule;
  }

  Future<List<ScheduleModel?>> markConsumed(List<int> ids, DateTime at) async {
    List<ScheduleModel?> schedules = await _database.scheduleModels.getAll(ids);

    final existingSchedules = schedules.whereType<ScheduleModel>().toList();
    if (existingSchedules.isEmpty) return schedules;

    await _database.writeTxn(() async {
      await _database.scheduleModels.putAll(
        existingSchedules
            .map(
              (schedule) => schedule.copyWith(
                consumedAt: Optional(at),
                status: Optional(ScheduleStatus.consumed),
                cancelledAt: Optional(null),
              ),
            )
            .toList(),
      );
    });
    schedules = await _database.scheduleModels.getAll(ids);

    return schedules;
  }

  Future<List<ScheduleModel?>> markCancelled(List<int> ids, DateTime at) async {
    final schedules = await _database.scheduleModels.getAll(ids);
    final existingSchedules = schedules.whereType<ScheduleModel>().toList();
    if (existingSchedules.isEmpty) return schedules;

    await _database.writeTxn(() async {
      await _database.scheduleModels.putAll(
        existingSchedules
            .map(
              (schedule) => schedule.copyWith(
                status: Optional(ScheduleStatus.cancelled),
                consumedAt: Optional(null),
                cancelledAt: Optional(at),
              ),
            )
            .toList(),
      );
    });
    return await _database.scheduleModels.getAll(ids);
  }

  Future<List<ScheduleModel>> pruneHistoryBefore(DateTime cutoff) async {
    final oldHistory = await _database.scheduleModels
        .filter()
        .statusEqualTo(ScheduleStatus.consumed)
        .triggerTimeLessThan(cutoff)
        .findAll();
    await _database.writeTxn(() async {
      await _database.scheduleModels
          .filter()
          .statusEqualTo(ScheduleStatus.consumed)
          .triggerTimeLessThan(cutoff)
          .deleteAll();
    });

    return oldHistory;
  }
}

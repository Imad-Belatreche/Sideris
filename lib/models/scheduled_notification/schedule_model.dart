import 'package:equatable/equatable.dart';
import 'package:isar_community/isar.dart';
import 'package:sideris/models/notification_rule/notification_rule_model.dart';

part 'schedule_model.g.dart';

enum ScheduleStatus { pending, consumed, cancelled }

@Collection(inheritance: false)
// ignore: must_be_immutable
class ScheduleModel extends Equatable {
  Id id = Isar.autoIncrement;

  //TODO: Add indexes later

  @Enumerated(EnumType.ordinal)
  ScheduleStatus status;

  int ruleId;

  DateTime triggerTime;
  DateTime? consumedAt;
  DateTime? cancelledAt;

  ScheduleModel({
    required this.ruleId,
    required this.triggerTime,
    this.status = ScheduleStatus.pending,
    this.consumedAt,
    this.cancelledAt,
  });

  @ignore
  /// This is only valid after inserting the `ScheduleNotification` to the database
  int get platformId {
    assert(id != Isar.autoIncrement);
    return id & 0x7FFFFFFF;
  }

  bool isOverdue(DateTime now) => triggerTime.isBefore(now);

  @ignore
  bool get isPending => status == ScheduleStatus.pending;

  ScheduleModel copyWith({
    Optional<DateTime>? triggerTime,
    Optional<DateTime?>? consumedAt,
    Optional<DateTime?>? cancelledAt,
    Optional<ScheduleStatus>? status,
  }) {
    return ScheduleModel(
      ruleId: ruleId,
      triggerTime: triggerTime != null ? triggerTime.value : this.triggerTime,
      status: status != null ? status.value : this.status,
      consumedAt: consumedAt != null ? consumedAt.value : this.consumedAt,
      cancelledAt: cancelledAt != null ? cancelledAt.value : this.cancelledAt,
    )..id = id;
  }

  @override
  @ignore
  List<Object?> get props => [
    id,
    ruleId,
    triggerTime,
    cancelledAt,
    consumedAt,
    status,
  ];
}

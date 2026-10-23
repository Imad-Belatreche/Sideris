import 'package:flutter_test/flutter_test.dart';
import 'package:sideris/models/notification_rule/notification_rule_model.dart';
import 'package:sideris/models/scheduled_notification/schedule_model.dart';

void main() {
  final triggerTime = DateTime(2026, 10, 24, 10);

  ScheduleModel createSchedule({
    ScheduleStatus status = ScheduleStatus.pending,
    DateTime? consumedAt,
    DateTime? cancelledAt,
  }) {
    return ScheduleModel(
      ruleId: 7,
      triggerTime: triggerTime,
      status: status,
      consumedAt: consumedAt,
      cancelledAt: cancelledAt,
    )..id = 42;
  }

  group("ScheduleModel", () {
    test("copyWith preserves cancelledAt when not overridden", () {
      final cancelledAt = DateTime(2026, 10, 23, 9);
      final schedule = createSchedule(cancelledAt: cancelledAt);

      final copy = schedule.copyWith();

      expect(copy.cancelledAt, equals(cancelledAt));
      expect(copy.consumedAt, isNull);
      expect(copy.id, equals(schedule.id));
    });

    test("marking consumed data clears cancellation fields", () {
      final schedule = createSchedule(
        status: ScheduleStatus.cancelled,
        cancelledAt: DateTime(2026, 10, 23, 9),
      );

      final consumed = schedule.copyWith(
        status: Optional(ScheduleStatus.consumed),
        consumedAt: Optional(DateTime(2026, 10, 24, 10)),
        cancelledAt: Optional(null),
      );

      expect(consumed.status, equals(ScheduleStatus.consumed));
      expect(consumed.consumedAt, isNotNull);
      expect(consumed.cancelledAt, isNull);
    });

    test("pending schedule is not history", () {
      final pending = createSchedule();
      final consumed = pending.copyWith(
        status: Optional(ScheduleStatus.consumed),
        consumedAt: Optional(DateTime(2026, 10, 24, 10)),
      );

      expect(pending.isPending, isTrue);
      expect(consumed.isPending, isFalse);
      expect(consumed.consumedAt, isNotNull);
    });
  });
}

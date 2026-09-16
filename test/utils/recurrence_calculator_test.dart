import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/models/notification_rule_model.dart';
import 'package:sideris/utils/recurrence_calculator.dart';

void main() {
  NotificationRuleModel makeRule({
    RepetitionType repetitionType = RepetitionType.repetitive,
    RecurrenceType? recurrenceType = RecurrenceType.specific,
    ScheduleUnit? scheduleUnit = ScheduleUnit.day,
    int? scheduleEvery = 1,
    List<int>? fixedTimesMinutes,
    List<int>? selectedDaysOfWeek,
    List<MonthDaysRepetition>? selectedMonthDays,
    DailyOption? dailyOption,
    int? randomCount,
    int? randomWindowStartMinutes,
    int? randomWindowEndMinutes,
    IntervalUnit? intervalUnit,
    int? intervalEvery,
    int? intervalWindowStartMinutes,
    int? intervalWindowEndMinutes,
    DateTime? startDate,
    DateTime? lastTriggeredAt,
    bool isForever = true,
    DateTime? endDate,
    int? totalOccurrences,
    int id = 1,
  }) {
    final now = DateTime.now();
    final rule = NotificationRuleModel(
      title: "test",
      startDate: startDate ?? now.subtract(const Duration(days: 1)),
      bypassDnd: false,
      repetitionType: repetitionType,
      recurrenceType: recurrenceType,
      fixedTimesMinutes: fixedTimesMinutes,
      scheduleUnit: scheduleUnit,
      scheduleEvery: scheduleEvery,
      selectedDaysOfWeek: selectedDaysOfWeek,
      selectedMonthDays: selectedMonthDays,
      dailyOption: dailyOption,
      randomCount: randomCount,
      randomWindowStartMinutes: randomWindowStartMinutes,
      randomWindowEndMinutes: randomWindowEndMinutes,
      intervalUnit: intervalUnit,
      intervalEvery: intervalEvery,
      intervalWindowStartMinutes: intervalWindowStartMinutes,
      intervalWindowEndMinutes: intervalWindowEndMinutes,
      isForever: isForever,
      endDate: endDate,
      totalOccurrences: totalOccurrences,
      lastTriggeredAt: lastTriggeredAt,
    )..id = id;
    return rule;
  }

  int toMinutes(TimeOfDay t) => t.hour * 60 + t.minute;
  TimeOfDay minutesAgo(int minutes) {
    final now = DateTime.now().subtract(Duration(minutes: minutes));
    return TimeOfDay(hour: now.hour, minute: now.minute);
  }

  group("computeDurationEndDate", () {
    test("returns null when unit or count is null", () {
      final start = DateTime(2026, 9, 13, 9);
      expect(
        RecurrenceCalculator.computeDurationEndDate(start, null, 5),
        isNull,
      );
      expect(
        RecurrenceCalculator.computeDurationEndDate(
          start,
          ScheduleUnit.day,
          null,
        ),
        isNull,
      );
      expect(
        RecurrenceCalculator.computeDurationEndDate(start, null, null),
        isNull,
      );
    });

    test("adds days", () {
      final start = DateTime(2026, 9, 13, 9, 30);
      expect(
        RecurrenceCalculator.computeDurationEndDate(start, ScheduleUnit.day, 5),
        equals(DateTime(2026, 9, 18, 9, 30)),
      );
    });

    test("adds weeks as 7 days", () {
      final start = DateTime(2026, 9, 13, 9);
      expect(
        RecurrenceCalculator.computeDurationEndDate(
          start,
          ScheduleUnit.week,
          2,
        ),
        equals(DateTime(2026, 9, 27, 9)),
      );
    });

    test("adds months with year rollover", () {
      final start = DateTime(2026, 11, 15, 9);
      expect(
        RecurrenceCalculator.computeDurationEndDate(
          start,
          ScheduleUnit.month,
          3,
        ),
        equals(DateTime(2027, 2, 15, 9)),
      );
    });

    test("clamps month-end (Jan 31 + 1 month -> Feb 28)", () {
      final start = DateTime(2026, 1, 31, 10, 5);
      // 2026 is not a leap year, Feb has 28 days.
      expect(
        RecurrenceCalculator.computeDurationEndDate(
          start,
          ScheduleUnit.month,
          1,
        ),
        equals(DateTime(2026, 2, 28, 10, 5)),
      );
    });

    test("adds years as 12 months with leap clamp", () {
      final start = DateTime(2024, 2, 29, 8);
      expect(
        RecurrenceCalculator.computeDurationEndDate(
          start,
          ScheduleUnit.year,
          1,
        ),
        equals(DateTime(2025, 2, 28, 8)),
      );
      expect(
        RecurrenceCalculator.computeDurationEndDate(
          DateTime(2026, 9, 13, 9),
          ScheduleUnit.year,
          2,
        ),
        equals(DateTime(2028, 9, 13, 9)),
      );
    });
  });

  group("isRuleActive", () {
    test("one-time in the past is inactive", () {
      final now = DateTime.now();
      final rule = makeRule(
        repetitionType: RepetitionType.oneTime,
        startDate: now.subtract(const Duration(days: 1)),
      );
      expect(RecurrenceCalculator.isRuleActive(rule, now), isFalse);
    });

    test("one-time in the future is active", () {
      final now = DateTime.now();
      final rule = makeRule(
        repetitionType: RepetitionType.oneTime,
        startDate: now.add(const Duration(days: 1)),
      );
      expect(RecurrenceCalculator.isRuleActive(rule, now), isTrue);
    });

    test("non-positive totalOccurrences is inactive", () {
      final now = DateTime.now();
      expect(
        RecurrenceCalculator.isRuleActive(makeRule(totalOccurrences: 0), now),
        isFalse,
      );
      expect(
        RecurrenceCalculator.isRuleActive(makeRule(totalOccurrences: -3), now),
        isFalse,
      );
      expect(
        RecurrenceCalculator.isRuleActive(makeRule(totalOccurrences: 2), now),
        isTrue,
      );
      expect(
        RecurrenceCalculator.isRuleActive(
          makeRule(totalOccurrences: null),
          now,
        ),
        isTrue,
      );
    });

    test("past endDate deactivates unless forever", () {
      final now = DateTime.now();
      final pastEnd = now.subtract(const Duration(days: 1));
      expect(
        RecurrenceCalculator.isRuleActive(
          makeRule(isForever: false, endDate: pastEnd),
          now,
        ),
        isFalse,
      );
      expect(
        RecurrenceCalculator.isRuleActive(
          makeRule(isForever: true, endDate: pastEnd),
          now,
        ),
        isTrue,
      );
      expect(
        RecurrenceCalculator.isRuleActive(
          makeRule(isForever: false, endDate: now.add(const Duration(days: 1))),
          now,
        ),
        isTrue,
      );
    });
  });

  group("computeNextTrigger one-time", () {
    test("future one-time returns startDate", () {
      final start = DateTime.now().add(const Duration(days: 2));
      final rule = makeRule(
        repetitionType: RepetitionType.oneTime,
        recurrenceType: null,
        scheduleUnit: null,
        scheduleEvery: null,
        startDate: start,
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.error, isNull);
      expect(res.nextTrigger, equals(start));
    });

    test("past one-time is not active", () {
      final rule = makeRule(
        repetitionType: RepetitionType.oneTime,
        recurrenceType: null,
        scheduleUnit: null,
        scheduleEvery: null,
        startDate: DateTime.now().subtract(const Duration(days: 1)),
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.nextTrigger, isNull);
      expect(res.error, isNotNull);
    });

    test("inactive one-time (occurrences exhausted) returns not-active", () {
      final rule = makeRule(
        repetitionType: RepetitionType.oneTime,
        recurrenceType: null,
        scheduleUnit: null,
        scheduleEvery: null,
        startDate: DateTime.now().add(const Duration(days: 1)),
        totalOccurrences: 0,
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.nextTrigger, isNull);
      expect(res.error.toString(), contains("not active"));
    });
  });

  group("computeNextTrigger specific daily", () {
    test("daily without filter returns future trigger", () {
      final rule = makeRule(
        fixedTimesMinutes: [toMinutes(TimeOfDay(hour: 23, minute: 59))],
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.error, isNull);
      expect(res.nextTrigger, isNotNull);
      expect(res.nextTrigger!.isAfter(DateTime.now()), isTrue);
    });

    test("past time today rolls to a later date", () {
      final past = minutesAgo(5);
      final rule = makeRule(fixedTimesMinutes: [toMinutes(past)]);
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.error, isNull);
      expect(res.nextTrigger, isNotNull);
      expect(res.nextTrigger!.isAfter(DateTime.now()), isTrue);
    });

    test("lastTriggeredAt advances the search", () {
      final rule = makeRule(
        fixedTimesMinutes: [toMinutes(TimeOfDay(hour: 9, minute: 0))],
        lastTriggeredAt: DateTime.now(),
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.error, isNull);
      final today = DateTime.now();
      final croppedToday = DateTime(today.year, today.month, today.day);
      expect(res.nextTrigger!.isAfter(croppedToday), isTrue);
    });

    test("scheduleEvery 2 skips a day", () {
      final rule = makeRule(
        scheduleEvery: 2,
        fixedTimesMinutes: [toMinutes(minutesAgo(5))],
        lastTriggeredAt: DateTime.now(),
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.error, isNull);
      // lastTriggered today + 2 days => at least tomorrow.
      final tomorrow = DateTime.now().add(const Duration(days: 1));
      final croppedTomorrow = DateTime(
        tomorrow.year,
        tomorrow.month,
        tomorrow.day,
      );
      expect(
        res.nextTrigger!.isAfter(
          croppedTomorrow.subtract(const Duration(seconds: 1)),
        ),
        isTrue,
      );
    });

    test("weekday filter restricts to selected weekdays", () {
      final rule = makeRule(
        selectedDaysOfWeek: [1, 2, 3, 4, 5],
        fixedTimesMinutes: [toMinutes(minutesAgo(5))],
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.error, isNull);
      expect(res.nextTrigger!.weekday, lessThanOrEqualTo(5));
    });

    test("missing fixedTimes throws", () {
      final rule = makeRule(fixedTimesMinutes: null);
      expect(
        () => RecurrenceCalculator.computeNextTrigger(rule),
        throwsA(isA<Exception>()),
      );
    });

    test("scheduleEvery != 1 with weekdays throws", () {
      final rule = makeRule(
        scheduleEvery: 2,
        selectedDaysOfWeek: [1],
        fixedTimesMinutes: [600],
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(rule),
        throwsException,
      );
    });

    test("invalid weekday throws", () {
      final rule = makeRule(selectedDaysOfWeek: [8], fixedTimesMinutes: [600]);
      expect(
        () => RecurrenceCalculator.computeNextTrigger(rule),
        throwsException,
      );
    });

    test("missing scheduleEvery/unit throws", () {
      final rule = makeRule(
        scheduleUnit: null,
        scheduleEvery: null,
        fixedTimesMinutes: [600],
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(rule),
        throwsException,
      );
    });

    test("non-positive scheduleEvery throws", () {
      final rule = makeRule(scheduleEvery: 0, fixedTimesMinutes: [600]);
      expect(
        () => RecurrenceCalculator.computeNextTrigger(rule),
        throwsException,
      );
    });
  });

  group("computeNextTrigger weekly/monthly/yearly", () {
    test("weekly lands on a selected weekday in the future", () {
      final now = DateTime.now();
      // Pick a weekday that is not today to force forward search.
      final target = (now.weekday % 7) + 1;
      final rule = makeRule(
        scheduleUnit: ScheduleUnit.week,
        selectedDaysOfWeek: [target],
        fixedTimesMinutes: [toMinutes(minutesAgo(60 * 5))],
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.error, isNull);
      expect(res.nextTrigger!.weekday, equals(target));
      expect(res.nextTrigger!.isAfter(now), isTrue);
    });

    test("weekly without days throws", () {
      final rule = makeRule(
        scheduleUnit: ScheduleUnit.week,
        selectedDaysOfWeek: null,
        fixedTimesMinutes: [600],
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(rule),
        throwsException,
      );
      final empty = makeRule(
        scheduleUnit: ScheduleUnit.week,
        selectedDaysOfWeek: [],
        fixedTimesMinutes: [600],
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(empty),
        throwsException,
      );
    });

    test("monthly lands on selected day", () {
      final rule = makeRule(
        scheduleUnit: ScheduleUnit.month,
        selectedMonthDays: [
          MonthDaysRepetition(selectedMonth: null, selectedDaysOfMonth: [15]),
        ],
        fixedTimesMinutes: [toMinutes(minutesAgo(60))],
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.error, isNull);
      expect(res.nextTrigger!.day, equals(15));
      expect(res.nextTrigger!.isAfter(DateTime.now()), isTrue);
    });

    test("monthly without days throws", () {
      final rule = makeRule(
        scheduleUnit: ScheduleUnit.month,
        selectedMonthDays: null,
        fixedTimesMinutes: [600],
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(rule),
        throwsException,
      );
    });

    test("yearly lands on selected month/day", () {
      final rule = makeRule(
        scheduleUnit: ScheduleUnit.year,
        selectedMonthDays: [
          MonthDaysRepetition(selectedMonth: 12, selectedDaysOfMonth: [25]),
        ],
        fixedTimesMinutes: [toMinutes(minutesAgo(60))],
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.error, isNull);
      expect(res.nextTrigger!.month, equals(12));
      expect(res.nextTrigger!.day, equals(25));
      expect(res.nextTrigger!.isAfter(DateTime.now()), isTrue);
    });

    test("yearly with invalid month/day throws", () {
      final badMonth = makeRule(
        scheduleUnit: ScheduleUnit.year,
        selectedMonthDays: [
          MonthDaysRepetition(selectedMonth: 13, selectedDaysOfMonth: [1]),
        ],
        fixedTimesMinutes: [600],
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(badMonth),
        throwsException,
      );

      final badDay = makeRule(
        scheduleUnit: ScheduleUnit.year,
        selectedMonthDays: [
          MonthDaysRepetition(selectedMonth: 5, selectedDaysOfMonth: [32]),
        ],
        fixedTimesMinutes: [600],
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(badDay),
        throwsException,
      );

      final missing = makeRule(
        scheduleUnit: ScheduleUnit.year,
        selectedMonthDays: [],
        fixedTimesMinutes: [600],
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(missing),
        throwsException,
      );
    });
  });

  group("computeNextTrigger interval", () {
    NotificationRuleModel intervalRule({
      int? every,
      IntervalUnit? unit,
      int? startMin,
      int? endMin,
    }) {
      return makeRule(
        recurrenceType: RecurrenceType.interval,
        fixedTimesMinutes: null,
        intervalEvery: every ?? 60,
        intervalUnit: unit ?? IntervalUnit.minute,
        intervalWindowStartMinutes: startMin ?? 0,
        intervalWindowEndMinutes: endMin ?? 1439,
      );
    }

    test("finds a slot inside the window after now", () {
      final res = RecurrenceCalculator.computeNextTrigger(intervalRule())!;
      expect(res.error, isNull);
      final trigger = res.nextTrigger!;
      expect(trigger.isAfter(DateTime.now()), isTrue);
      final mins = trigger.hour * 60 + trigger.minute;
      expect(mins, greaterThanOrEqualTo(0));
      expect(mins, lessThanOrEqualTo(1439));
    });

    test("hour unit steps from window start", () {
      final res = RecurrenceCalculator.computeNextTrigger(
        intervalRule(
          every: 2,
          unit: IntervalUnit.hour,
          startMin: 480,
          endMin: 1200,
        ),
      )!;
      expect(res.error, isNull);
      expect(res.nextTrigger, isNotNull);
      expect(res.nextTrigger!.isAfter(DateTime.now()), isTrue);
    });

    test("invalid window (start >= end) throws", () {
      expect(
        () => RecurrenceCalculator.computeNextTrigger(
          intervalRule(startMin: 1200, endMin: 480),
        ),
        throwsException,
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(
          intervalRule(startMin: 600, endMin: 600),
        ),
        throwsException,
      );
    });

    test("non-positive or missing interval config throws", () {
      expect(
        () => RecurrenceCalculator.computeNextTrigger(intervalRule(every: 0)),
        throwsException,
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(
          makeRule(
            recurrenceType: RecurrenceType.interval,
            fixedTimesMinutes: null,
            intervalEvery: null,
            intervalUnit: null,
            intervalWindowStartMinutes: null,
            intervalWindowEndMinutes: null,
          ),
        ),
        throwsException,
      );
    });
  });

  group("computeNextTrigger random", () {
    NotificationRuleModel randomRule({
      int? count,
      int? startMin,
      int? endMin,
      int id = 7,
    }) {
      return makeRule(
        recurrenceType: RecurrenceType.random,
        fixedTimesMinutes: null,
        randomCount: count ?? 2,
        randomWindowStartMinutes: startMin ?? 0,
        randomWindowEndMinutes: endMin ?? 1439,
        id: id,
      );
    }

    test("returns a future slot inside the window", () {
      final res = RecurrenceCalculator.computeNextTrigger(randomRule())!;
      expect(res.error, isNull);
      final trigger = res.nextTrigger!;
      expect(trigger.isAfter(DateTime.now()), isTrue);
      final mins = trigger.hour * 60 + trigger.minute;
      expect(mins, greaterThanOrEqualTo(0));
      expect(mins, lessThanOrEqualTo(1439));
    });

    test("is deterministic for the same rule and day", () {
      final a = RecurrenceCalculator.computeNextTrigger(randomRule(id: 42))!;
      final b = RecurrenceCalculator.computeNextTrigger(randomRule(id: 42))!;
      expect(a.nextTrigger, equals(b.nextTrigger));
    });

    test("invalid random config throws", () {
      expect(
        () => RecurrenceCalculator.computeNextTrigger(randomRule(count: 0)),
        throwsException,
      );
      expect(
        () => RecurrenceCalculator.computeNextTrigger(
          randomRule(startMin: 1200, endMin: 480),
        ),
        throwsException,
      );
    });

    test("count exceeding window minutes throws", () {
      // 60-minute window (600..659) but 120 requested slots.
      expect(
        () => RecurrenceCalculator.computeNextTrigger(
          randomRule(count: 120, startMin: 600, endMin: 659),
        ),
        throwsException,
      );
    });
  });

  group("computeNextTrigger duration guard", () {
    test("trigger past endDate returns not-active-at-trigger-time", () {
      final now = DateTime.now();
      final pastTime = minutesAgo(5);
      final rule = makeRule(
        fixedTimesMinutes: [toMinutes(pastTime)],
        isForever: false,
        // Ends ~1 minute from now; computed trigger is forced to tomorrow
        // because today's slot is already in the past.
        endDate: now.add(const Duration(minutes: 1)),
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.nextTrigger, isNull);
      expect(res.error.toString(), contains("not active"));
    });

    test("exhausted totalOccurrences returns not-active", () {
      final rule = makeRule(
        fixedTimesMinutes: [toMinutes(TimeOfDay(hour: 23, minute: 59))],
        totalOccurrences: 0,
      );
      final res = RecurrenceCalculator.computeNextTrigger(rule)!;
      expect(res.nextTrigger, isNull);
      expect(res.error.toString(), contains("not active"));
    });
  });
}

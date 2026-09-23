import 'package:flutter_test/flutter_test.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/models/notification_rule_model.dart';

void main() {
  NotificationRuleModel createRule({
    RepetitionType repetitionType = RepetitionType.repetitive,
    RecurrenceType? recurrenceType = RecurrenceType.specific,
    ScheduleUnit? scheduleUnit = ScheduleUnit.day,
    DailyOption? dailyOption,
    int? scheduleEvery = 1,
    List<int>? selectedDaysOfWeek,
    List<MonthDaysRepetition>? selectedMonthDays,
    List<int>? fixedTimesMinutes,
    int? randomCount,
    int? randomWindowStartMinutes,
    int? randomWindowEndMinutes,
    IntervalUnit? intervalUnit,
    int? intervalEvery,
    int? intervalWindowStartMinutes,
    int? intervalWindowEndMinutes,
    bool isForever = true,
    ScheduleUnit? durationUnit,
    int? durationCount,
    DateTime? endDate,
    int? totalOccurrences,
    String? content,
  }) {
    return NotificationRuleModel(
      title: "Test reminder",
      content: content,
      startDate: DateTime(2026, 9, 13, 9),
      bypassDnd: false,
      repetitionType: repetitionType,
      recurrenceType: recurrenceType,
      fixedTimesMinutes: fixedTimesMinutes,
      scheduleUnit: scheduleUnit,
      dailyOption: dailyOption,
      scheduleEvery: scheduleEvery,
      selectedDaysOfWeek: selectedDaysOfWeek,
      selectedMonthDays: selectedMonthDays,
      randomCount: randomCount,
      randomWindowStartMinutes: randomWindowStartMinutes,
      randomWindowEndMinutes: randomWindowEndMinutes,
      intervalUnit: intervalUnit,
      intervalEvery: intervalEvery,
      intervalWindowStartMinutes: intervalWindowStartMinutes,
      intervalWindowEndMinutes: intervalWindowEndMinutes,
      isForever: isForever,
      durationUnit: durationUnit,
      durationCount: durationCount,
      endDate: endDate,
      totalOccurrences: totalOccurrences,
    );
  }

  group("fixedTimes converter", () {
    test("convert fixed times to minutes", () {
      final rule = createRule();
      rule.fixedTimes = [
        TimeOfDay(hour: 9, minute: 30),
        TimeOfDay(hour: 17, minute: 45),
      ];

      expect(rule.fixedTimesMinutes, equals([570, 1065]));
    });

    test("convert minutes back to fixed times", () {
      final rule = createRule()..fixedTimesMinutes = [570, 1065];

      expect(
        rule.fixedTimes,
        equals([
          TimeOfDay(hour: 9, minute: 30),
          TimeOfDay(hour: 17, minute: 45),
        ]),
      );
    });

    test("returns null when minutes are null", () {
      final rule = createRule()..fixedTimesMinutes = null;

      expect(rule.fixedTimes, isNull);
    });

    test("returns null when minutes are empty", () {
      final rule = createRule()..fixedTimesMinutes = [];

      expect(rule.fixedTimes, isNull);
    });

    test("setting empty list clears minutes to null", () {
      final rule = createRule()..fixedTimesMinutes = [570];
      rule.fixedTimes = [];

      expect(rule.fixedTimesMinutes, isNull);
    });

    test("setting null clears minutes to null", () {
      final rule = createRule()..fixedTimesMinutes = [570];
      rule.fixedTimes = null;

      expect(rule.fixedTimesMinutes, isNull);
    });

    test("midnight and end-of-day round-trip", () {
      final rule = createRule();
      rule.fixedTimes = [
        TimeOfDay(hour: 0, minute: 0),
        TimeOfDay(hour: 23, minute: 59),
      ];

      expect(rule.fixedTimesMinutes, equals([0, 1439]));
      expect(
        rule.fixedTimes,
        equals([
          TimeOfDay(hour: 0, minute: 0),
          TimeOfDay(hour: 23, minute: 59),
        ]),
      );
    });
  });

  group("window converters", () {
    test("interval window minutes to TimeOfDay", () {
      final rule = createRule()
        ..intervalWindowStartMinutes = 570
        ..intervalWindowEndMinutes = 1065;

      expect(rule.intervalWindowStart, equals(TimeOfDay(hour: 9, minute: 30)));
      expect(rule.intervalWindowEnd, equals(TimeOfDay(hour: 17, minute: 45)));
    });

    test("interval window TimeOfDay to minutes", () {
      final rule = createRule()
        ..intervalWindowStart = TimeOfDay(hour: 9, minute: 30)
        ..intervalWindowEnd = TimeOfDay(hour: 17, minute: 45);

      expect(rule.intervalWindowStartMinutes, equals(570));
      expect(rule.intervalWindowEndMinutes, equals(1065));
    });

    test("interval window null handling", () {
      final rule = createRule()
        ..intervalWindowStartMinutes = null
        ..intervalWindowEndMinutes = null;

      expect(rule.intervalWindowStart, isNull);
      expect(rule.intervalWindowEnd, isNull);

      rule
        ..intervalWindowStart = TimeOfDay(hour: 8, minute: 0)
        ..intervalWindowStart = null
        ..intervalWindowEnd = TimeOfDay(hour: 8, minute: 0)
        ..intervalWindowEnd = null;

      expect(rule.intervalWindowStartMinutes, isNull);
      expect(rule.intervalWindowEndMinutes, isNull);
    });

    test("random window minutes to TimeOfDay", () {
      final rule = createRule()
        ..randomWindowStartMinutes = 480
        ..randomWindowEndMinutes = 1200;

      expect(rule.randomWindowStart, equals(TimeOfDay(hour: 8, minute: 0)));
      expect(rule.randomWindowEnd, equals(TimeOfDay(hour: 20, minute: 0)));
    });

    test("random window TimeOfDay to minutes", () {
      final rule = createRule()
        ..randomWindowStart = TimeOfDay(hour: 8, minute: 0)
        ..randomWindowEnd = TimeOfDay(hour: 20, minute: 0);

      expect(rule.randomWindowStartMinutes, equals(480));
      expect(rule.randomWindowEndMinutes, equals(1200));
    });

    test("random window null handling", () {
      final rule = createRule()
        ..randomWindowStartMinutes = null
        ..randomWindowEndMinutes = null;

      expect(rule.randomWindowStart, isNull);
      expect(rule.randomWindowEnd, isNull);

      rule
        ..randomWindowStart = TimeOfDay(hour: 8, minute: 0)
        ..randomWindowStart = null
        ..randomWindowEnd = TimeOfDay(hour: 8, minute: 0)
        ..randomWindowEnd = null;

      expect(rule.randomWindowStartMinutes, isNull);
      expect(rule.randomWindowEndMinutes, isNull);
    });

    test("midnight window boundary", () {
      final rule = createRule()
        ..intervalWindowStart = TimeOfDay(hour: 0, minute: 0)
        ..intervalWindowEnd = TimeOfDay(hour: 23, minute: 59);

      expect(rule.intervalWindowStartMinutes, equals(0));
      expect(rule.intervalWindowEndMinutes, equals(1439));
      expect(rule.intervalWindowStart, equals(TimeOfDay(hour: 0, minute: 0)));
      expect(rule.intervalWindowEnd, equals(TimeOfDay(hour: 23, minute: 59)));
    });
  });

  group("boolean helpers", () {
    test("repetition helpers", () {
      expect(
        createRule(repetitionType: RepetitionType.repetitive).isRepetitive,
        isTrue,
      );
      expect(
        createRule(repetitionType: RepetitionType.repetitive).isOneTime,
        isFalse,
      );
      expect(
        createRule(repetitionType: RepetitionType.oneTime).isOneTime,
        isTrue,
      );
      expect(
        createRule(repetitionType: RepetitionType.oneTime).isRepetitive,
        isFalse,
      );
    });

    test("recurrence helpers", () {
      expect(
        createRule(recurrenceType: RecurrenceType.specific).isSpecific,
        isTrue,
      );
      expect(
        createRule(recurrenceType: RecurrenceType.random).isRandom,
        isTrue,
      );
      expect(
        createRule(recurrenceType: RecurrenceType.interval).isInterval,
        isTrue,
      );
      expect(createRule(recurrenceType: null).isSpecific, isFalse);
      expect(createRule(recurrenceType: null).isRandom, isFalse);
      expect(createRule(recurrenceType: null).isInterval, isFalse);
      expect(
        createRule(recurrenceType: RecurrenceType.specific).isRandom,
        isFalse,
      );
      expect(
        createRule(recurrenceType: RecurrenceType.interval).isSpecific,
        isFalse,
      );
    });

    test("usesFixedTimes", () {
      expect(createRule(fixedTimesMinutes: [570]).usesFixedTimes, isTrue);
      expect(createRule(fixedTimesMinutes: null).usesFixedTimes, isFalse);
      expect(createRule(fixedTimesMinutes: []).usesFixedTimes, isFalse);
    });

    test("usesWindowedSchedule requires both ends", () {
      expect(
        createRule(
          intervalWindowStartMinutes: 480,
          intervalWindowEndMinutes: 1200,
        ).usesWindowedSchedule,
        isTrue,
      );
      expect(
        createRule(
          intervalWindowStartMinutes: 480,
          intervalWindowEndMinutes: null,
        ).usesWindowedSchedule,
        isFalse,
      );
      expect(
        createRule(
          intervalWindowStartMinutes: null,
          intervalWindowEndMinutes: 1200,
        ).usesWindowedSchedule,
        isFalse,
      );
      expect(createRule().usesWindowedSchedule, isFalse);
    });
  });

  group("constructor defaults", () {
    test("applies expected defaults", () {
      final before = DateTime.now();
      final rule = NotificationRuleModel(
        title: "t",
        startDate: DateTime(2026, 9, 13),
        bypassDnd: true,
        repetitionType: RepetitionType.oneTime,
      );
      final after = DateTime.now();

      expect(rule.isActive, isTrue);
      expect(rule.isScheduled, isFalse);
      expect(rule.isForever, isFalse);
      expect(rule.content, isNull);
      expect(rule.colorTag, isNull);
      expect(
        rule.createdAt!.isAfter(before.subtract(const Duration(seconds: 1))) &&
            rule.createdAt!.isBefore(after.add(const Duration(seconds: 1))),
        isTrue,
      );
    });
  });

  group("copyWith", () {
    test("overrides simple fields and preserves untouched ones", () {
      final rule = createRule();
      final copied = rule.copyWith(
        title: "new",
        bypassDnd: true,
        isActive: false,
        isScheduled: true,
      );

      expect(copied.title, equals("new"));
      expect(copied.bypassDnd, isTrue);
      expect(copied.isActive, isFalse);
      expect(copied.isScheduled, isTrue);
      // untouched
      expect(copied.startDate, equals(rule.startDate));
      expect(copied.repetitionType, equals(rule.repetitionType));
      expect(copied.scheduleUnit, equals(rule.scheduleUnit));
    });

    test("preserves id", () {
      final rule = createRule()..id = 42;
      final copied = rule.copyWith(title: "changed");

      expect(copied.id, equals(42));
    });

    test(
      "content Optional semantics: absent preserves, null clears, value sets",
      () {
        final rule = createRule(content: "keep");

        expect(rule.copyWith().content, equals("keep"));
        expect(
          rule.copyWith(content: const Optional<String?>(null)).content,
          isNull,
        );
        expect(
          rule.copyWith(content: const Optional<String?>("new")).content,
          equals("new"),
        );
      },
    );

    test("recurrenceType Optional semantics", () {
      final rule = createRule(recurrenceType: RecurrenceType.specific);

      expect(rule.copyWith().recurrenceType, equals(RecurrenceType.specific));
      expect(
        rule
            .copyWith(recurrenceType: const Optional<RecurrenceType?>(null))
            .recurrenceType,
        isNull,
      );
      expect(
        rule
            .copyWith(
              recurrenceType: const Optional<RecurrenceType?>(
                RecurrenceType.random,
              ),
            )
            .recurrenceType,
        equals(RecurrenceType.random),
      );
    });

    test("fixedTimes via copyWith converts, clears, and preserves", () {
      final rule = createRule(fixedTimesMinutes: [570]);

      final preserved = rule.copyWith();
      expect(preserved.fixedTimesMinutes, equals([570]));

      final updated = rule.copyWith(
        fixedTimes: Optional([
          TimeOfDay(hour: 8, minute: 0),
          TimeOfDay(hour: 20, minute: 15),
        ]),
      );
      expect(updated.fixedTimesMinutes, equals([480, 1215]));

      final cleared = rule.copyWith(fixedTimes: const Optional(null));
      expect(cleared.fixedTimesMinutes, isNull);
    });

    test("interval fields via copyWith", () {
      final rule = createRule(
        recurrenceType: RecurrenceType.interval,
        intervalUnit: IntervalUnit.hour,
        intervalEvery: 2,
        intervalWindowStartMinutes: 480,
        intervalWindowEndMinutes: 1200,
      );

      final copied = rule.copyWith(
        intervalUnit: const Optional<IntervalUnit?>(IntervalUnit.minute),
        intervalEvery: const Optional<int?>(30),
        intervalWindowStart: Optional(TimeOfDay(hour: 9, minute: 0)),
        intervalWindowEnd: const Optional<TimeOfDay?>(null),
      );

      expect(copied.intervalUnit, equals(IntervalUnit.minute));
      expect(copied.intervalEvery, equals(30));
      expect(copied.intervalWindowStartMinutes, equals(540));
      expect(copied.intervalWindowEndMinutes, isNull);
    });

    test("random fields via copyWith", () {
      final rule = createRule(recurrenceType: RecurrenceType.random);

      final copied = rule.copyWith(
        randomCount: const Optional<int?>(3),
        randomWindowStart: Optional(TimeOfDay(hour: 7, minute: 30)),
        randomWindowEnd: Optional(TimeOfDay(hour: 22, minute: 0)),
      );

      expect(copied.randomCount, equals(3));
      expect(copied.randomWindowStartMinutes, equals(450));
      expect(copied.randomWindowEndMinutes, equals(1320));
    });

    test("schedule fields via copyWith", () {
      final rule = createRule();

      final copied = rule.copyWith(
        scheduleUnit: const Optional<ScheduleUnit?>(ScheduleUnit.week),
        dailyOption: const Optional<DailyOption?>(null),
        scheduleEvery: const Optional<int?>(2),
        selectedDaysOfWeek: const Optional<List<int>?>([1, 3, 5]),
        selectedMonthDays: Optional([
          MonthDaysRepetition(selectedMonth: 9, selectedDaysOfMonth: [13]),
        ]),
      );

      expect(copied.scheduleUnit, equals(ScheduleUnit.week));
      expect(copied.dailyOption, isNull);
      expect(copied.scheduleEvery, equals(2));
      expect(copied.selectedDaysOfWeek, equals([1, 3, 5]));
      expect(copied.selectedMonthDays!.single.selectedMonth, equals(9));
    });

    test("duration and trigger fields via copyWith", () {
      final rule = createRule(isForever: false);
      final end = DateTime(2026, 10, 1);
      final next = DateTime(2026, 9, 14, 9);
      final last = DateTime(2026, 9, 13, 9);

      final copied = rule.copyWith(
        isForever: true,
        endDate: Optional(end),
        totalOccurrences: const Optional<int?>(10),
        durationUnit: const Optional<ScheduleUnit?>(ScheduleUnit.week),
        durationCount: const Optional<int?>(2),
        lastTriggeredAt: Optional(last),
        nextTriggerAt: Optional(next),
      );

      expect(copied.isForever, isTrue);
      expect(copied.endDate, equals(end));
      expect(copied.totalOccurrences, equals(10));
      expect(copied.durationUnit, equals(ScheduleUnit.week));
      expect(copied.durationCount, equals(2));
      expect(copied.lastTriggeredAt, equals(last));
      expect(copied.nextTriggerAt, equals(next));
    });
  });

  group("normalized recurrence", () {
    test("one-time clears recurrence and all repetitive-only fields", () {
      final rule = NotificationRuleModel(
        title: "one",
        startDate: DateTime(2026, 9, 13, 9),
        bypassDnd: false,
        repetitionType: RepetitionType.oneTime,
        recurrenceType: RecurrenceType.specific,
        fixedTimesMinutes: [570],
        scheduleUnit: ScheduleUnit.week,
        dailyOption: DailyOption.weekdays,
        scheduleEvery: 2,
        selectedDaysOfWeek: [1, 2],
        selectedMonthDays: [
          MonthDaysRepetition(selectedMonth: 9, selectedDaysOfMonth: [13]),
        ],
        randomCount: 3,
        randomWindowStartMinutes: 480,
        randomWindowEndMinutes: 1200,
        intervalUnit: IntervalUnit.hour,
        intervalEvery: 1,
        intervalWindowStartMinutes: 480,
        intervalWindowEndMinutes: 1200,
        isForever: true,
      );

      final normalized = rule.normalized();

      expect(normalized.recurrenceType, isNull);
      expect(normalized.fixedTimesMinutes, isNull);
      expect(normalized.randomCount, isNull);
      expect(normalized.randomWindowStartMinutes, isNull);
      expect(normalized.randomWindowEndMinutes, isNull);
      expect(normalized.intervalEvery, isNull);
      expect(normalized.intervalUnit, isNull);
      expect(normalized.intervalWindowStartMinutes, isNull);
      expect(normalized.intervalWindowEndMinutes, isNull);
      expect(normalized.scheduleUnit, isNull);
      expect(normalized.dailyOption, isNull);
      expect(normalized.scheduleEvery, isNull);
      expect(normalized.selectedDaysOfWeek, isNull);
      expect(normalized.selectedMonthDays, isNull);
    });

    test("specific keeps fixed times and clears random/interval", () {
      final rule = createRule(
        recurrenceType: RecurrenceType.specific,
        fixedTimesMinutes: [570],
        randomCount: 3,
        randomWindowStartMinutes: 480,
        randomWindowEndMinutes: 1200,
        intervalUnit: IntervalUnit.hour,
        intervalEvery: 2,
        intervalWindowStartMinutes: 480,
        intervalWindowEndMinutes: 1200,
      );

      final normalized = rule.normalized();

      expect(normalized.recurrenceType, equals(RecurrenceType.specific));
      expect(normalized.fixedTimesMinutes, equals([570]));
      expect(normalized.randomCount, isNull);
      expect(normalized.randomWindowStartMinutes, isNull);
      expect(normalized.randomWindowEndMinutes, isNull);
      expect(normalized.intervalEvery, isNull);
      expect(normalized.intervalUnit, isNull);
      expect(normalized.intervalWindowStartMinutes, isNull);
      expect(normalized.intervalWindowEndMinutes, isNull);
    });

    test("random keeps random fields and clears fixed/interval", () {
      final rule = createRule(
        recurrenceType: RecurrenceType.random,
        fixedTimesMinutes: [570],
        randomCount: 3,
        randomWindowStartMinutes: 480,
        randomWindowEndMinutes: 1200,
        intervalUnit: IntervalUnit.hour,
        intervalEvery: 2,
        intervalWindowStartMinutes: 480,
        intervalWindowEndMinutes: 1200,
      );

      final normalized = rule.normalized();

      expect(normalized.recurrenceType, equals(RecurrenceType.random));
      expect(normalized.randomCount, equals(3));
      expect(normalized.randomWindowStartMinutes, equals(480));
      expect(normalized.randomWindowEndMinutes, equals(1200));
      expect(normalized.fixedTimesMinutes, isNull);
      expect(normalized.intervalEvery, isNull);
      expect(normalized.intervalUnit, isNull);
    });

    test("interval keeps interval fields and clears fixed/random", () {
      final rule = createRule(
        recurrenceType: RecurrenceType.interval,
        fixedTimesMinutes: [570],
        randomCount: 3,
        randomWindowStartMinutes: 480,
        randomWindowEndMinutes: 1200,
        intervalUnit: IntervalUnit.minute,
        intervalEvery: 30,
        intervalWindowStartMinutes: 480,
        intervalWindowEndMinutes: 1200,
      );

      final normalized = rule.normalized();

      expect(normalized.recurrenceType, equals(RecurrenceType.interval));
      expect(normalized.intervalUnit, equals(IntervalUnit.minute));
      expect(normalized.intervalEvery, equals(30));
      expect(normalized.intervalWindowStartMinutes, equals(480));
      expect(normalized.intervalWindowEndMinutes, equals(1200));
      expect(normalized.fixedTimesMinutes, isNull);
      expect(normalized.randomCount, isNull);
      expect(normalized.randomWindowStartMinutes, isNull);
      expect(normalized.randomWindowEndMinutes, isNull);
    });

    test("null recurrence clears specific/random/interval payloads", () {
      final rule = createRule(
        recurrenceType: null,
        fixedTimesMinutes: [570],
        randomCount: 3,
        randomWindowStartMinutes: 480,
        randomWindowEndMinutes: 1200,
        intervalUnit: IntervalUnit.hour,
        intervalEvery: 2,
        intervalWindowStartMinutes: 480,
        intervalWindowEndMinutes: 1200,
      );

      final normalized = rule.normalized();

      expect(normalized.recurrenceType, isNull);
      expect(normalized.fixedTimesMinutes, isNull);
      expect(normalized.randomCount, isNull);
      expect(normalized.intervalEvery, isNull);
      expect(normalized.intervalUnit, isNull);
    });
  });

  group("normalized schedule", () {
    test("day + allDays keeps daily option and clears days of week", () {
      final normalized = createRule(
        scheduleUnit: ScheduleUnit.day,
        dailyOption: DailyOption.allDays,
        selectedDaysOfWeek: [1, 2],
      ).normalized();

      expect(normalized.scheduleUnit, equals(ScheduleUnit.day));
      expect(normalized.dailyOption, equals(DailyOption.allDays));
      expect(normalized.selectedDaysOfWeek, isNull);
      expect(normalized.scheduleEvery, equals(1));
    });

    test("day + weekdays keeps both daily option and days of week", () {
      final normalized = createRule(
        scheduleUnit: ScheduleUnit.day,
        dailyOption: DailyOption.weekdays,
        selectedDaysOfWeek: [1, 2, 3, 4, 5],
      ).normalized();

      expect(normalized.dailyOption, equals(DailyOption.weekdays));
      expect(normalized.selectedDaysOfWeek, equals([1, 2, 3, 4, 5]));
    });

    test("day + weekends keeps both daily option and days of week", () {
      final normalized = createRule(
        scheduleUnit: ScheduleUnit.day,
        dailyOption: DailyOption.weekends,
        selectedDaysOfWeek: [6, 7],
      ).normalized();

      expect(normalized.dailyOption, equals(DailyOption.weekends));
      expect(normalized.selectedDaysOfWeek, equals([6, 7]));
    });

    test("week keeps days of week and clears daily option", () {
      final normalized = createRule(
        scheduleUnit: ScheduleUnit.week,
        dailyOption: DailyOption.weekdays,
        selectedDaysOfWeek: [1, 3],
      ).normalized();

      expect(normalized.scheduleUnit, equals(ScheduleUnit.week));
      expect(normalized.dailyOption, isNull);
      expect(normalized.selectedDaysOfWeek, equals([1, 3]));
    });

    test("month keeps month-days and clears days of week", () {
      final monthDays = [
        MonthDaysRepetition(selectedMonth: null, selectedDaysOfMonth: [1, 15]),
      ];
      final normalized = createRule(
        scheduleUnit: ScheduleUnit.month,
        dailyOption: DailyOption.weekdays,
        selectedDaysOfWeek: [1],
        selectedMonthDays: monthDays,
      ).normalized();

      expect(normalized.selectedMonthDays, isNotNull);
      expect(
        normalized.selectedMonthDays!.single.selectedDaysOfMonth,
        equals([1, 15]),
      );
      expect(normalized.selectedDaysOfWeek, isNull);
      expect(normalized.dailyOption, isNull);
    });

    test("year keeps month-days and clears days of week", () {
      final monthDays = [
        MonthDaysRepetition(selectedMonth: 9, selectedDaysOfMonth: [13]),
        MonthDaysRepetition(selectedMonth: 12, selectedDaysOfMonth: [25]),
      ];
      final normalized = createRule(
        scheduleUnit: ScheduleUnit.year,
        selectedDaysOfWeek: [1],
        selectedMonthDays: monthDays,
      ).normalized();

      expect(normalized.selectedMonthDays!.length, equals(2));
      expect(normalized.selectedDaysOfWeek, isNull);
    });

    test("day/week clears month-days", () {
      final monthDays = [
        MonthDaysRepetition(selectedMonth: 9, selectedDaysOfMonth: [13]),
      ];
      expect(
        createRule(
          scheduleUnit: ScheduleUnit.day,
          selectedMonthDays: monthDays,
        ).normalized().selectedMonthDays,
        isNull,
      );
      expect(
        createRule(
          scheduleUnit: ScheduleUnit.week,
          selectedMonthDays: monthDays,
        ).normalized().selectedMonthDays,
        isNull,
      );
    });
  });

  group("normalized duration", () {
    test("normalize forever rule by clearing duration fields", () {
      final rule = createRule()
        ..durationUnit = ScheduleUnit.week
        ..durationCount = 2
        ..endDate = DateTime(2026, 9, 27)
        ..totalOccurrences = 5;

      final normalized = rule.normalized();

      expect(normalized.isForever, isTrue);
      expect(normalized.durationUnit, isNull);
      expect(normalized.durationCount, isNull);
      expect(normalized.endDate, isNull);
      expect(normalized.totalOccurrences, isNull);
    });

    test("non-forever preserves duration fields", () {
      final end = DateTime(2026, 9, 27);
      final normalized = createRule(
        isForever: false,
        durationUnit: ScheduleUnit.week,
        durationCount: 2,
        endDate: end,
        totalOccurrences: 5,
      ).normalized();

      expect(normalized.isForever, isFalse);
      expect(normalized.durationUnit, equals(ScheduleUnit.week));
      expect(normalized.durationCount, equals(2));
      expect(normalized.endDate, equals(end));
      expect(normalized.totalOccurrences, equals(5));
    });
  });

  group("misc", () {
    test("MonthDaysRepetition toString includes fields", () {
      final value = MonthDaysRepetition(
        selectedMonth: 9,
        selectedDaysOfMonth: [13, 14],
      );

      expect(value.toString(), contains("9"));
      expect(value.toString(), contains("13"));
    });

    test("toString includes identifying fields", () {
      final rule = createRule()..id = 7;

      expect(rule.toString(), contains("Test reminder"));
      expect(rule.toString(), contains("7"));
    });
  });
}

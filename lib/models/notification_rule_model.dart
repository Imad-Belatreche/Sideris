// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:flutter/material.dart';
import 'package:isar/isar.dart';

part 'notification_rule_model.g.dart';

//TODO: Maybe i'll add an "isActive" field to the model, so that we can deactivate a notification rule without deleting it, and then we can have a separate collection for "archived" notification rules, so that we can keep track of them and maybe even restore them later.

enum ColorTag {
  green(Colors.green),
  blue(Colors.blue),
  cyan(Colors.cyan),
  red(Colors.red),
  yellow(Colors.yellow),
  purple(Colors.purple),
  pink(Colors.pink),
  orange(Colors.orange);

  final Color value;

  const ColorTag(this.value);
}

enum RepetitionType { oneTime, repetitive }

enum RecurrenceType { specific, random, interval }

enum ScheduleUnit { day, week, month, year }

enum IntervalUnit { minute, hour }

class Optional<T> {
  final T value;
  const Optional(this.value);
}

@embedded
class MonthDaysRepetition {
  int? selectedMonth;
  List<int>? selectedDaysOfMonth;
}

@Collection()
class NotificationRuleModel {
  Id id = Isar.autoIncrement;

  // These will be in every single type ------------------------------------
  String title;
  String? content;
  DateTime startDate;
  @Enumerated(EnumType.name)
  ColorTag? colorTag;
  bool bypassDnd;
  
  @Index(
    composite: [CompositeIndex("isScheduled"), CompositeIndex("nextTriggerAt")],
  )
  bool isActive = true;
  bool isScheduled = false;

  /// Choose recurrence `Specific`, `Random`, `Interval`
  @Enumerated(EnumType.name)
  RecurrenceType recurrenceType;

  /// Choose between `One-Time` or `Repetitive`
  @Enumerated(EnumType.name)
  RepetitionType repetitionType;
  // -----------------------------------------------------------------------

  /// This will be used for `Specific` recurrence
  List<int>? fixedTimesMinutes;

  @Enumerated(EnumType.name)
  IntervalUnit? intervalUnit;
  int? intervalEvery;
  int? intervalWindowStartMinutes;
  int? intervalWindowEndMinutes;

  /// This will be used when choosing a schedule, such that user will 4 chips [Day, Week, Month, Year]
  /// and will see under them a field saying "Every" then they enter a number [scheduleEvery].
  /// On month, they will choose which days of month, on year they will choose which months, and which days.
  /// Default [scheduleEvery] on UI will be 1 (every day, every week, every month...etc).
  /// Weekdays/Weekends will be handled through the UI and will set the correct [selectedDaysOfWeek]
  @Enumerated(EnumType.name)
  ScheduleUnit? scheduleUnit;
  int? scheduleEvery;
  // Monday, Tuesday, Wednesday....etc == 1, 2, 3 ...etc
  List<int>? selectedDaysOfWeek;

  // Months from 1 to 12, 1 = January, 12 = December
  // Days from 1 to 30/31
  List<MonthDaysRepetition>? selectedMonthDays;

  /// For `Random` recurrence type, a field will ask for "How many times" to enter the [randomCount] and then two time fields for [randomWindowStartMinutes] and [randomWindowEndMinutes]
  int? randomCount;
  int? randomWindowStartMinutes;
  int? randomWindowEndMinutes;

  /// For Duration
  bool isForever;
  DateTime? endDate;
  int? totalOccurrences;

  @Enumerated(EnumType.name)
  ScheduleUnit? durationUnit;
  int? durationCount;

  DateTime? lastTriggeredAt;

  DateTime? nextTriggerAt;

  DateTime createdAt;

  @ignore
  TimeOfDay? get intervalWindowStart {
    if (intervalWindowStartMinutes != null) {
      return TimeOfDay(
        hour: intervalWindowStartMinutes! ~/ 60,
        minute: intervalWindowStartMinutes! % 60,
      );
    } else {
      return null;
    }
  }

  set intervalWindowStart(TimeOfDay? value) {
    if (value != null) {
      intervalWindowStartMinutes = value.hour * 60 + value.minute;
    } else {
      intervalWindowStartMinutes = null;
    }
  }

  @ignore
  TimeOfDay? get intervalWindowEnd {
    if (intervalWindowEndMinutes != null) {
      return TimeOfDay(
        hour: intervalWindowEndMinutes! ~/ 60,
        minute: intervalWindowEndMinutes! % 60,
      );
    } else {
      return null;
    }
  }

  set intervalWindowEnd(TimeOfDay? value) {
    if (value != null) {
      intervalWindowEndMinutes = value.hour * 60 + value.minute;
    } else {
      intervalWindowEndMinutes = null;
    }
  }

  @ignore
  TimeOfDay? get randomWindowStart {
    if (randomWindowStartMinutes != null) {
      return TimeOfDay(
        hour: randomWindowStartMinutes! ~/ 60,
        minute: randomWindowStartMinutes! % 60,
      );
    } else {
      return null;
    }
  }

  set randomWindowStart(TimeOfDay? value) {
    if (value != null) {
      randomWindowStartMinutes = value.hour * 60 + value.minute;
    } else {
      randomWindowStartMinutes = null;
    }
  }

  @ignore
  TimeOfDay? get randomWindowEnd {
    if (randomWindowEndMinutes != null) {
      return TimeOfDay(
        hour: randomWindowEndMinutes! ~/ 60,
        minute: randomWindowEndMinutes! % 60,
      );
    } else {
      return null;
    }
  }

  set randomWindowEnd(TimeOfDay? value) {
    if (value != null) {
      randomWindowEndMinutes = value.hour * 60 + value.minute;
    } else {
      randomWindowEndMinutes = null;
    }
  }

  @ignore
  List<TimeOfDay>? get fixedTimes {
    if (fixedTimesMinutes != null && fixedTimesMinutes!.isNotEmpty) {
      return fixedTimesMinutes!
          .map((e) => TimeOfDay(hour: e ~/ 60, minute: e % 60))
          .toList();
    } else {
      return null;
    }
  }

  set fixedTimes(List<TimeOfDay>? list) {
    if (list != null && list.isNotEmpty) {
      fixedTimesMinutes = list.map((e) => e.hour * 60 + e.minute).toList();
    } else {
      fixedTimesMinutes = null;
    }
  }

  @ignore
  bool get isRepetitive => repetitionType == RepetitionType.repetitive;

  @ignore
  bool get isOneTime => repetitionType == RepetitionType.oneTime;

  @ignore
  bool get isSpecific => recurrenceType == RecurrenceType.specific;

  @ignore
  bool get isRandom => recurrenceType == RecurrenceType.random;

  @ignore
  bool get isInterval => recurrenceType == RecurrenceType.interval;

  @ignore
  bool get usesFixedTimes => fixedTimes != null && fixedTimes!.isNotEmpty;

  @ignore
  bool get usesWindowedSchedule =>
      intervalWindowStart != null && intervalWindowEnd != null;

  NotificationRuleModel({
    required this.title,
    this.content,
    required this.startDate,
    this.colorTag,
    required this.bypassDnd,
    this.isActive = true,
    this.isScheduled = false,

    required this.repetitionType,
    required this.recurrenceType,
    this.fixedTimesMinutes,

    this.intervalUnit,
    this.intervalEvery,
    this.intervalWindowStartMinutes,
    this.intervalWindowEndMinutes,

    this.scheduleUnit,
    this.scheduleEvery,
    this.selectedDaysOfWeek,
    this.selectedMonthDays,

    this.randomCount,
    this.randomWindowStartMinutes,
    this.randomWindowEndMinutes,

    required this.isForever,
    this.endDate,
    this.totalOccurrences,
    this.durationUnit,
    this.durationCount,

    this.lastTriggeredAt,
    this.nextTriggerAt,
  }) : createdAt = DateTime.now();
  NotificationRuleModel copyWith(
    String? title,
    Optional<String?>? content,
    DateTime? startDate,
    ColorTag? colorTag,
    bool? bypassDnd,
    bool? isActive,
    bool? isScheduled,

    RepetitionType? repetitionType,
    RecurrenceType? recurrenceType,

    Optional<List<TimeOfDay>?>? fixedTimes,

    Optional<IntervalUnit?>? intervalUnit,
    Optional<int?>? intervalEvery,
    Optional<TimeOfDay?>? intervalWindowStart,
    Optional<TimeOfDay?>? intervalWindowEnd,

    Optional<ScheduleUnit?>? scheduleUnit,
    Optional<int?>? scheduleEvery,
    Optional<List<int>?>? selectedDaysOfWeek,
    Optional<List<MonthDaysRepetition>?>? selectedMonthDays,

    Optional<int?>? randomCount,
    Optional<TimeOfDay?>? randomWindowStart,
    Optional<TimeOfDay?>? randomWindowEnd,

    bool? isForever,
    Optional<DateTime?>? endDate,
    Optional<int?>? totalOccurrences,
    Optional<ScheduleUnit?>? durationUnit,
    Optional<int?>? durationCount,

    DateTime? lastTriggeredAt,
    DateTime? nextTriggerAt,
  ) {
    final List<int>? fixedTimesMinutes = fixedTimes != null
        ? (fixedTimes.value?.map((e) => e.hour * 60 + e.minute).toList())
        : this.fixedTimesMinutes;

    final int? intervalWindowStartMinutes = intervalWindowStart != null
        ? (intervalWindowStart.value != null
              ? intervalWindowStart.value!.hour * 60 +
                    intervalWindowStart.value!.minute
              : null)
        : this.intervalWindowStartMinutes;

    final int? intervalWindowEndMinutes = intervalWindowEnd != null
        ? (intervalWindowEnd.value != null
              ? intervalWindowEnd.value!.hour * 60 +
                    intervalWindowEnd.value!.minute
              : null)
        : this.intervalWindowEndMinutes;

    final int? randomWindowStartMinutes = randomWindowStart != null
        ? (randomWindowStart.value != null
              ? randomWindowStart.value!.hour * 60 +
                    randomWindowStart.value!.minute
              : null)
        : this.randomWindowStartMinutes;

    final int? randomWindowEndMinutes = randomWindowEnd != null
        ? (randomWindowEnd.value != null
              ? randomWindowEnd.value!.hour * 60 + randomWindowEnd.value!.minute
              : null)
        : this.randomWindowEndMinutes;

    return NotificationRuleModel(
      title: title ?? this.title,
      content: content != null ? content.value : this.content,
      startDate: startDate ?? this.startDate,
      repetitionType: repetitionType ?? this.repetitionType,
      recurrenceType: recurrenceType ?? this.recurrenceType,
      colorTag: colorTag ?? this.colorTag,
      bypassDnd: bypassDnd ?? this.bypassDnd,
      isActive: isActive ?? this.isActive,
      isScheduled: isScheduled ?? this.isScheduled,

      fixedTimesMinutes: fixedTimesMinutes,

      intervalUnit: intervalUnit != null
          ? intervalUnit.value
          : this.intervalUnit,
      intervalEvery: intervalEvery != null
          ? intervalEvery.value
          : this.intervalEvery,
      intervalWindowStartMinutes: intervalWindowStartMinutes,
      intervalWindowEndMinutes: intervalWindowEndMinutes,

      scheduleUnit: scheduleUnit != null
          ? scheduleUnit.value
          : this.scheduleUnit,
      scheduleEvery: scheduleEvery != null
          ? scheduleEvery.value
          : this.scheduleEvery,
      selectedDaysOfWeek: selectedDaysOfWeek != null
          ? selectedDaysOfWeek.value
          : this.selectedDaysOfWeek,
      selectedMonthDays: selectedMonthDays != null
          ? selectedMonthDays.value
          : this.selectedMonthDays,

      randomCount: randomCount != null ? randomCount.value : this.randomCount,
      randomWindowStartMinutes: randomWindowStartMinutes,
      randomWindowEndMinutes: randomWindowEndMinutes,

      isForever: isForever ?? this.isForever,
      endDate: endDate != null ? endDate.value : this.endDate,
      durationUnit: durationUnit != null
          ? durationUnit.value
          : this.durationUnit,
      durationCount: durationCount != null
          ? durationCount.value
          : this.durationCount,
      totalOccurrences: totalOccurrences != null
          ? totalOccurrences.value
          : this.totalOccurrences,

      lastTriggeredAt: lastTriggeredAt ?? this.lastTriggeredAt,
      nextTriggerAt: nextTriggerAt ?? this.nextTriggerAt,
    )..id = id;
  }
}

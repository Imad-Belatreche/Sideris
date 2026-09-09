import 'dart:math';

import 'package:sideris/models/notification_rule_model.dart';

class RecurrenceCalculationResponse {
  final DateTime? nextTrigger;
  final Exception? error;

  RecurrenceCalculationResponse({
    required this.nextTrigger,
    required this.error,
  });
}

class RecurrenceCalculator {
  static int _daysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  // Will only return the next trigger date, without considering time.
  static DateTime _timeCropping(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
  }

  static DateTime _nextDailyDate({
    required DateTime searchDate,
    required List<int>? selectedWeekdays,
  }) {
    if (selectedWeekdays == null || selectedWeekdays.isEmpty) {
      return searchDate;
    }

    var candidate = searchDate;

    while (!selectedWeekdays.contains(candidate.weekday)) {
      candidate = candidate.add(const Duration(days: 1));
    }

    return candidate;
  }

  static DateTime _nextWeeklyDate({
    required DateTime searchDate,
    required int scheduleEvery,
    required List<int> selectedWeekdays,
  }) {
    final sortedWeekdays = [...selectedWeekdays]..sort();

    final weekStart = searchDate.subtract(
      Duration(days: searchDate.weekday - 1),
    );

    for (final weekday in sortedWeekdays) {
      final candidate = weekStart.add(Duration(days: weekday - 1));

      if (!candidate.isBefore(searchDate)) {
        return candidate;
      }
    }

    final nextWeekStart = weekStart.add(Duration(days: scheduleEvery * 7));
    return nextWeekStart.add(Duration(days: sortedWeekdays.first - 1));
  }

  static DateTime? _nextMonthlyDate({
    required int year,
    required int month,
    required int minimumDay,
    required List<int> selectedDays,
  }) {
    final lastDay = _daysInMonth(year, month);

    for (final day in selectedDays) {
      if (day >= minimumDay && day <= lastDay) {
        return DateTime(year, month, day);
      }
    }

    return null;
  }

  static DateTime? _nextYearlyDate({
    required int year,
    required int minimumMonth,
    required int minimumDay,
    required List<MapEntry<int, int>> selectedDates,
  }) {
    for (final selectedDate in selectedDates) {
      final month = selectedDate.key;
      final day = selectedDate.value;

      if (month < minimumMonth) {
        continue;
      }

      if (month == minimumMonth && day < minimumDay) {
        continue;
      }

      if (day > _daysInMonth(year, month)) {
        continue;
      }

      return DateTime(year, month, day);
    }

    return null;
  }

  static DateTime _dateFinder(
    NotificationRuleModel rule, {
    DateTime? lastTriggeredAt,
  }) {
    if (rule.scheduleEvery == null || rule.scheduleUnit == null) {
      throw Exception('Schedule every and schedule unit must be provided');
    }

    if (rule.scheduleEvery! <= 0) {
      throw Exception('Schedule every must be greater than 0');
    }

    DateTime now = DateTime.now();
    now = _timeCropping(now);
    final effectiveLastTriggeredAt = lastTriggeredAt ?? rule.lastTriggeredAt;

    var anchorDate = now.isAfter(rule.startDate)
        ? effectiveLastTriggeredAt ?? now
        : rule.startDate;

    anchorDate = _timeCropping(anchorDate);

    switch (rule.scheduleUnit!) {
      case ScheduleUnit.day:
        final selectedWeekdays = rule.selectedDaysOfWeek;

        if (selectedWeekdays != null && selectedWeekdays.isNotEmpty) {
          if (rule.scheduleEvery != 1) {
            throw Exception(
              'scheduleEvery should be 1 when setting weekdays or weekends.',
            );
          }

          for (final weekday in selectedWeekdays) {
            if (weekday < 1 || weekday > 7) {
              throw Exception('Selected weekday must be between 1 and 7.');
            }
          }
        }

        var searchDate = effectiveLastTriggeredAt == null
            ? anchorDate
            : _timeCropping(
                effectiveLastTriggeredAt,
              ).add(Duration(days: rule.scheduleEvery!));

        return _nextDailyDate(
          searchDate: searchDate,
          selectedWeekdays: selectedWeekdays,
        );

      case ScheduleUnit.week:
        if (rule.selectedDaysOfWeek == null ||
            rule.selectedDaysOfWeek!.isEmpty) {
          throw Exception(
            'Selected days of week must be provided for weekly recurrence.',
          );
        }

        for (final weekday in rule.selectedDaysOfWeek!) {
          if (weekday < 1 || weekday > 7) {
            throw Exception('Selected weekday must be between 1 and 7.');
          }
        }

        var searchDate = effectiveLastTriggeredAt == null
            ? anchorDate
            : _timeCropping(effectiveLastTriggeredAt);

        if (effectiveLastTriggeredAt != null) {
          searchDate = searchDate.add(const Duration(days: 1));
        }

        return _nextWeeklyDate(
          searchDate: searchDate,
          scheduleEvery: rule.scheduleEvery!,
          selectedWeekdays: rule.selectedDaysOfWeek!,
        );

      case ScheduleUnit.month:
        if (rule.selectedMonthDays == null ||
            rule.selectedMonthDays!.isEmpty ||
            rule.selectedMonthDays!.first.selectedDaysOfMonth == null ||
            rule.selectedMonthDays!.first.selectedDaysOfMonth!.isEmpty) {
          throw Exception(
            "Selected month days must be provided for monthly recurrence.",
          );
        }

        final selectedDays = [
          ...rule.selectedMonthDays!.first.selectedDaysOfMonth!,
        ]..sort();

        var searchDate = effectiveLastTriggeredAt == null
            ? anchorDate
            : _timeCropping(effectiveLastTriggeredAt);

        if (effectiveLastTriggeredAt != null) {
          searchDate = searchDate.add(Duration(days: 1));
        }

        while (true) {
          final candidate = _nextMonthlyDate(
            year: searchDate.year,
            month: searchDate.month,
            minimumDay: searchDate.day,
            selectedDays: selectedDays,
          );

          if (candidate != null) {
            return candidate;
          }

          searchDate = DateTime(
            searchDate.year,
            searchDate.month + rule.scheduleEvery!,
            1,
          );
        }

      case ScheduleUnit.year:
        if (rule.selectedMonthDays == null || rule.selectedMonthDays!.isEmpty) {
          throw Exception(
            'Selected month days must be provided for yearly recurrence.',
          );
        } else {
          for (var md in rule.selectedMonthDays!) {
            if (md.selectedMonth == null ||
                md.selectedDaysOfMonth == null ||
                md.selectedDaysOfMonth!.isEmpty) {
              throw Exception(
                'Selected month and days of month must be provided for each selected month.',
              );
            }
          }
        }

        final selectedDates = <MapEntry<int, int>>[];

        for (final monthDays in rule.selectedMonthDays!) {
          final month = monthDays.selectedMonth;
          final days = monthDays.selectedDaysOfMonth;

          if (month == null ||
              month < 1 ||
              month > 12 ||
              days == null ||
              days.isEmpty) {
            throw Exception(
              'Each yearly selection must contain a valid month and at least one day.',
            );
          }

          for (final day in days) {
            if (day < 1 || day > 31) {
              throw Exception('Selected day must be between 1 and 31.');
            }

            selectedDates.add(MapEntry(month, day));
          }
        }

        selectedDates.sort((a, b) {
          final monthComparison = a.key.compareTo(b.key);
          return monthComparison != 0
              ? monthComparison
              : a.value.compareTo(b.value);
        });

        var searchDate = effectiveLastTriggeredAt == null
            ? anchorDate
            : _timeCropping(effectiveLastTriggeredAt);

        if (effectiveLastTriggeredAt != null) {
          searchDate = searchDate.add(const Duration(days: 1));
        }

        while (true) {
          final candidate = _nextYearlyDate(
            year: searchDate.year,
            minimumMonth: searchDate.month,
            minimumDay: searchDate.day,
            selectedDates: selectedDates,
          );

          if (candidate != null) {
            return candidate;
          }

          searchDate = DateTime(searchDate.year + rule.scheduleEvery!, 1, 1);
        }
    }
  }

  static DateTime? _timeFinder(
    DateTime triggerDate,
    NotificationRuleModel rule,
  ) {
    final now = DateTime.now();

    if (rule.isSpecific) {
      if (rule.fixedTimes == null || rule.fixedTimes!.isEmpty) {
        throw Exception("Specific repetition but fixedTimes was not provided");
      }

      for (var time in rule.fixedTimes!) {
        triggerDate = triggerDate.copyWith(
          hour: time.hour,
          minute: time.minute,
        );

        if (now.isBefore(triggerDate)) {
          break;
        }
      }

      if (now.isBefore(triggerDate)) {
        return triggerDate;
      } else {
        return null;
      }
    } else if (rule.isInterval) {
      if (rule.intervalWindowStart == null ||
          rule.intervalWindowEnd == null ||
          rule.intervalEvery == null ||
          rule.intervalUnit == null ||
          rule.intervalEvery! <= 0) {
        throw Exception(
          "Interval repetition but intervalWindowStart, intervalWindowEnd, intervalEvery, or intervalUnit was not provided or invalid",
        );
      }

      if (rule.intervalWindowStart!.isAfter(rule.intervalWindowEnd!) ||
          rule.intervalWindowStartMinutes! == rule.intervalWindowEndMinutes!) {
        throw Exception(
          "Interval window start must be before interval window end",
        );
      }

      DateTime slot = triggerDate.copyWith(
        hour: rule.intervalWindowStart!.hour,
        minute: rule.intervalWindowStart!.minute,
      );

      final windowEnd = triggerDate.copyWith(
        hour: rule.intervalWindowEnd!.hour,
        minute: rule.intervalWindowEnd!.minute,
      );
      final step = Duration(
        minutes: rule.intervalUnit == IntervalUnit.minute
            ? rule.intervalEvery!
            : rule.intervalEvery! * 60,
      );

      while (!slot.isAfter(windowEnd)) {
        if (slot.isAfter(now)) return slot;
        slot = slot.add(step);
      }

      return null;
    } else if (rule.isRandom) {
      if (rule.randomWindowStart == null ||
          rule.randomWindowEnd == null ||
          rule.randomCount == null ||
          rule.randomCount! <= 0) {
        throw Exception(
          "Random repetition but randomWindowStart, randomWindowEnd, randomCount, or randomUnit was not provided or invalid",
        );
      }

      List<DateTime> randomSlotsFor(
        DateTime triggerDate,
        NotificationRuleModel rule,
      ) {
        final seed =
            rule.id.hashCode ^
            triggerDate.year ^
            (triggerDate.month << 8) ^
            (triggerDate.day << 16);
        final rng = Random(seed);

        final startMin = rule.randomWindowStartMinutes!;
        final endMin = rule.randomWindowEndMinutes!;
        final span = endMin - startMin;

        final minutesList = List.generate(
          rule.randomCount!,
          (_) => startMin + rng.nextInt(span + 1),
        )..sort();

        return minutesList.map((m) {
          return DateTime(
            triggerDate.year,
            triggerDate.month,
            triggerDate.day,
            m ~/ 60,
            m % 60,
          );
        }).toList();
      }

      final slots = randomSlotsFor(triggerDate, rule);

      for (final slot in slots) {
        if (slot.isAfter(now)) return slot;
      }

      return null;
    } else {
      throw Exception("Repetition type not specified");
    }
  }

  static bool isRuleActive(
    NotificationRuleModel rule,
    DateTime evaluationTime,
  ) {
    if (rule.isOneTime && rule.startDate.isBefore(evaluationTime)) {
      return false;
    }

    if (rule.totalOccurrences != null && rule.totalOccurrences! <= 0) {
      return false;
    }

    if (rule.endDate != null &&
        !rule.isForever &&
        rule.endDate!.isBefore(evaluationTime)) {
      return false;
    }

    return true;
  }

  static RecurrenceCalculationResponse? computeNextTrigger(
    NotificationRuleModel rule,
  ) {
    final now = DateTime.now();

    if (!isRuleActive(rule, now)) {
      return RecurrenceCalculationResponse(
        nextTrigger: null,
        error: Exception('Notification rule is not active'),
      );
    }

    if (rule.isOneTime) {
      if (rule.startDate.isAfter(now)) {
        return RecurrenceCalculationResponse(
          nextTrigger: rule.startDate,
          error: null,
        );
      } else {
        return RecurrenceCalculationResponse(
          nextTrigger: null,
          error: Exception('One-time notification has already occurred'),
        );
      }
    }

    DateTime candidateDate = _dateFinder(rule);
    DateTime? result;
    var guard = 0;
    while (result == null) {
      result = _timeFinder(candidateDate, rule);
      if (result == null) {
        candidateDate = _dateFinder(rule, lastTriggeredAt: candidateDate);
      }
      if (++guard > 1000) {
        throw Exception(
          'Could not find a valid trigger within 1000 iterations — check rule configuration',
        );
      }
    }
    if (!isRuleActive(rule, result)) {
      return RecurrenceCalculationResponse(
        nextTrigger: null,
        error: Exception(
          'Notification rule is not active at the computed trigger time',
        ),
      );
    }
    return RecurrenceCalculationResponse(nextTrigger: result, error: null);
  }
}

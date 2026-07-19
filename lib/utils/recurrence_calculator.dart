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
  // Will only return the next trigger date, without considering time.
  static DateTime _timeCropping(DateTime dateTime) {
    return DateTime(dateTime.year, dateTime.month, dateTime.day);
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
        if (rule.selectedDaysOfWeek != null &&
            rule.selectedDaysOfWeek!.isNotEmpty) {
          if (rule.scheduleEvery! != 1) {
            throw Exception(
              "scheduleEvery should be 1 when setting weekdays or weekends",
            );
          }
        }

        if (effectiveLastTriggeredAt != null) {
          var result = effectiveLastTriggeredAt;
          result = _timeCropping(result);

          result = result.add(Duration(days: rule.scheduleEvery!));

          while (!result.isAfter(now)) {
            result = result.add(Duration(days: rule.scheduleEvery!));
          }

          if (rule.selectedDaysOfWeek != null &&
              rule.selectedDaysOfWeek!.isNotEmpty) {
            while (!rule.selectedDaysOfWeek!.contains(result.weekday)) {
              result = result.add(const Duration(days: 1));
            }
          }

          anchorDate = result;
        } else {
          if (rule.selectedDaysOfWeek != null &&
              rule.selectedDaysOfWeek!.isNotEmpty) {
            while (!rule.selectedDaysOfWeek!.contains(anchorDate.weekday)) {
              anchorDate = anchorDate.add(const Duration(days: 1));
            }
          }
        }

        return anchorDate;

      case ScheduleUnit.week:
        if (rule.selectedDaysOfWeek == null ||
            rule.selectedDaysOfWeek!.isEmpty) {
          throw Exception(
            'Selected days of week must be provided for weekly recurrence.',
          );
        }

        if (effectiveLastTriggeredAt != null) {
          var result = effectiveLastTriggeredAt;
          result = _timeCropping(result);

          while (!result.isAfter(now)) {
            while (!rule.selectedDaysOfWeek!.contains(result.weekday)) {
              result = result.add(Duration(days: 1));
            }

            if (result.weekday == rule.selectedDaysOfWeek!.last &&
                !result.isAfter(now)) {
              result = result.add(
                Duration(
                  days:
                      (7 * rule.scheduleEvery!) -
                      rule.selectedDaysOfWeek!.last +
                      rule.selectedDaysOfWeek!.first,
                ),
              );
            } else if (!result.isAfter(now)) {
              result = result.add(Duration(days: 1));

              while (!rule.selectedDaysOfWeek!.contains(result.weekday)) {
                result = result.add(Duration(days: 1));
              }
            }
          }

          anchorDate = result;
        } else {
          while (!rule.selectedDaysOfWeek!.contains(anchorDate.weekday)) {
            anchorDate = anchorDate.add(Duration(days: 1));
          }
        }

        return anchorDate;

      case ScheduleUnit.month:
        if (rule.selectedMonthDays == null || rule.selectedMonthDays!.isEmpty) {
          throw Exception(
            "Selected month days must be provided for monthly recurrence.",
          );
        }

        if (effectiveLastTriggeredAt != null) {
          var result = effectiveLastTriggeredAt;
          result = _timeCropping(result);

          while (!result.isAfter(now)) {
            if (result.day ==
                rule.selectedMonthDays!.first.selectedDaysOfMonth!.last) {
              result = result.copyWith(
                month: result.month + rule.scheduleEvery!,
                day: rule.selectedMonthDays!.first.selectedDaysOfMonth!.first,
              );
            } else {
              if (result.day >
                  rule.selectedMonthDays!.first.selectedDaysOfMonth!.last) {
                result = result.copyWith(
                  month: result.month + rule.scheduleEvery!,
                  day: rule.selectedMonthDays!.first.selectedDaysOfMonth!.first,
                );
              } else {
                for (var day
                    in rule.selectedMonthDays!.first.selectedDaysOfMonth!) {
                  if (day > result.day) {
                    result = result.copyWith(day: day);
                    break;
                  }
                }
              }
            }
          }

          anchorDate = result;
        } else {
          if (anchorDate.day >
              rule.selectedMonthDays!.first.selectedDaysOfMonth!.last) {
            anchorDate = anchorDate.copyWith(
              month: anchorDate.month + rule.scheduleEvery!,
              day: rule.selectedMonthDays!.first.selectedDaysOfMonth!.first,
            );
          } else {
            for (var day
                in rule.selectedMonthDays!.first.selectedDaysOfMonth!) {
              if (day > anchorDate.day) {
                anchorDate = anchorDate.copyWith(day: day);
                break;
              } else if (day == anchorDate.day) {
                break;
              }
            }
          }
        }

        return anchorDate;

      case ScheduleUnit.year:
        if (rule.selectedMonthDays == null || rule.selectedMonthDays!.isEmpty) {
          throw Exception(
            'Selected month days must be provided for yearly recurrence.',
          );
        } else {
          for (var md in rule.selectedMonthDays!) {
            if (md.selectedMonth == null || md.selectedDaysOfMonth!.isEmpty) {
              throw Exception(
                'Selected month and days of month must be provided for each selected month.',
              );
            }
          }
        }

        final sortedPairs = <MapEntry<int, int>>[];
        for (var md in rule.selectedMonthDays!) {
          for (var day in md.selectedDaysOfMonth!) {
            sortedPairs.add(MapEntry(md.selectedMonth!, day));
          }
        }

        if (effectiveLastTriggeredAt != null) {
          var result = effectiveLastTriggeredAt;
          result = _timeCropping(result);

          while (!result.isAfter(now)) {
            var found = false;

            for (var pair in sortedPairs) {
              if (pair.key > result.month ||
                  (pair.key == result.month && pair.value > result.day)) {
                result = result.copyWith(month: pair.key, day: pair.value);
                found = true;
                break;
              }
            }

            if (!found) {
              result = result.copyWith(
                year: result.year + rule.scheduleEvery!,
                month: rule.selectedMonthDays!.first.selectedMonth!,
                day: rule.selectedMonthDays!.first.selectedDaysOfMonth!.first,
              );
            }
          }

          anchorDate = result;
        } else {
          var found = false;

          for (var pair in sortedPairs) {
            if (pair.key > anchorDate.month ||
                (pair.key == anchorDate.month && pair.value > anchorDate.day)) {
              anchorDate = anchorDate.copyWith(
                month: pair.key,
                day: pair.value,
              );
              found = true;
              break;
            } else if (pair.key == anchorDate.month &&
                pair.value == anchorDate.day) {
              found = true;
              break;
            }
          }

          if (!found) {
            anchorDate = anchorDate.copyWith(
              year: anchorDate.year + rule.scheduleEvery!,
              month: rule.selectedMonthDays!.first.selectedMonth!,
              day: rule.selectedMonthDays!.first.selectedDaysOfMonth!.first,
            );
          }
        }

        return anchorDate;
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

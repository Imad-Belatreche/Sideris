import 'package:sideris/l10n/generated/app_localizations.dart';
import 'package:sideris/models/notification_rule_model.dart';

extension RepetitionTypeLabel on RepetitionType {
  String label(AppLocalizations l10n) => switch (this) {
    RepetitionType.oneTime => l10n.repetitionTypeOneTime,
    RepetitionType.repetitive => l10n.repetitionTypeRepetitive,
  };
}

extension RecurrenceTypeLabel on RecurrenceType {
  String label(AppLocalizations l10n) => switch (this) {
    RecurrenceType.specific => l10n.recurrenceTypeSpecific,
    RecurrenceType.random => l10n.recurrenceTypeRandom,
    RecurrenceType.interval => l10n.recurrenceTypeInterval,
  };
}

extension DailyOptionLabel on DailyOption {
  String label(AppLocalizations l10n) => switch (this) {
    DailyOption.allDays => l10n.dailyOptionAllDays,
    DailyOption.weekdays => l10n.dailyOptionWeekdays,
    DailyOption.weekends => l10n.dailyOptionWeekends,
  };
}

extension DurationOptionLabel on DurationOption {
  String label(AppLocalizations l10n) => switch (this) {
    DurationOption.forever => l10n.durationOptionForever,
    DurationOption.duration => l10n.durationOptionDuration,
    DurationOption.untilDate => l10n.durationOptionUntilDate,
    DurationOption.occurrences => l10n.durationOptionOccurrences,
  };
}

extension IntervalUnitLabel on IntervalUnit {
  String label(AppLocalizations l10n) => switch (this) {
    IntervalUnit.hour => l10n.notificationPageIntervalUnit('hour'),
    IntervalUnit.minute => l10n.notificationPageIntervalUnit('minute'),
  };

  String unit(int count, AppLocalizations l10n) => switch (this) {
    IntervalUnit.hour => l10n.unitHour(count),
    IntervalUnit.minute => l10n.unitMinute(count),
  };
}

extension ScheduleUnitLabel on ScheduleUnit {
  String label(AppLocalizations l10n) => switch (this) {
    ScheduleUnit.daily => l10n.scheduleUnitDaily,
    ScheduleUnit.weekly => l10n.scheduleUnitWeekly,
    ScheduleUnit.monthly => l10n.scheduleUnitMonthly,
    ScheduleUnit.yearly => l10n.scheduleUnitYearly,
  };

  String shortLabel(AppLocalizations l10n) => switch (this) {
    ScheduleUnit.daily => l10n.scheduleUnitDay,
    ScheduleUnit.weekly => l10n.scheduleUnitWeek,
    ScheduleUnit.monthly => l10n.scheduleUnitMonth,
    ScheduleUnit.yearly => l10n.scheduleUnitYear,
  };

  String unit(int count, AppLocalizations l10n) => switch (this) {
    ScheduleUnit.daily => l10n.unitDay(count),
    ScheduleUnit.weekly => l10n.unitWeek(count),
    ScheduleUnit.monthly => l10n.unitMonth(count),
    ScheduleUnit.yearly => l10n.unitYear(count),
  };
}

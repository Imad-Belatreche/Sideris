// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Sideris';

  @override
  String get actionUndo => 'Undo';

  @override
  String get actionWarning => 'Warning';

  @override
  String get actionCancel => 'Cancel';

  @override
  String get actionDelete => 'Delete';

  @override
  String get actionCreate => 'Create';

  @override
  String get actionUpdate => 'Update';

  @override
  String get actionSave => 'Save';

  @override
  String get actionStart => 'Start';

  @override
  String get actionOkay => 'Okay';

  @override
  String get actionTo => 'to';

  @override
  String get actionAddTime => 'Add Time';

  @override
  String get actionOpenSettings => 'Open Settings';

  @override
  String get actionSelectDate => 'Select date';

  @override
  String get actionSelectTime => 'Select time';

  @override
  String get actionCreateNotification => 'Create Notification';

  @override
  String get actionUpdateNotification => 'Update Notification';

  @override
  String get navHome => 'Home';

  @override
  String get navSettings => 'Settings';

  @override
  String get greetingMorning => 'Good morning';

  @override
  String get greetingAfternoon => 'Good afternoon';

  @override
  String get greetingEvening => 'Good evening';

  @override
  String get homePageCalendarNoRules => 'No rules planned for this day';

  @override
  String homePageCalendarRulesPlanned(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count rules planned',
      one: '1 rule planned',
    );
    return '$_temp0';
  }

  @override
  String get homePageCalendarTapToInspectRules =>
      'Tap another day to inspect its rules.';

  @override
  String get homePageListAllActive => 'All Active Rules';

  @override
  String get homePageNotificationDeleteDialogContent =>
      'This notification rule will be permanently deleted.\n\nAre you sure about that?';

  @override
  String get homePageNotificationDeleted => 'Notification deleted';

  @override
  String get settingsPageTitle => 'Settings';

  @override
  String settingsPageLoadingError(String errorMessage) {
    return 'An error happened while loading settings: $errorMessage';
  }

  @override
  String get settingsPageTheme => 'Theme';

  @override
  String get settingsPageLanguage => 'Language';

  @override
  String get settingsPageDefaultNotificationTemplate =>
      'Default notification template';

  @override
  String get settingsPageDefaultRepetition => 'Default Repetition';

  @override
  String get settingsPageDefaultRecurrence => 'Default Recurrence';

  @override
  String get settingsPageDefaultTiming => 'Default Timing';

  @override
  String get settingsPageDefaultDuration => 'Default Duration';

  @override
  String get settingsPageSavedSettings => 'Settings have been saved';

  @override
  String get settingsPageDefaultDescriptionHint => '(Default is empty)';

  @override
  String get fieldTitle => 'Title';

  @override
  String get fieldDescription => 'Description';

  @override
  String get notificationPageCreateTitle => 'Create Notification';

  @override
  String get notificationPageUpdateTitle => 'Update Notification';

  @override
  String get notificationPageTitleHint => 'Notification title';

  @override
  String get notificationPageContentTitle => 'Content (optional)';

  @override
  String get notificationPageContentHint => 'Add details...';

  @override
  String get notificationPageColorTag => 'Color Tag';

  @override
  String get notificationPageRepetitionType => 'Repetition Type';

  @override
  String get notificationPageOptions => 'Options';

  @override
  String get notificationPageDateAndTime => 'Date & Time';

  @override
  String get notificationPageSchedule => 'Schedule';

  @override
  String get notificationPageStartFromNow => 'From now';

  @override
  String get notificationPagePickDateAndTime => 'Pick date & time';

  @override
  String get notificationPageDateSelectionCanceled =>
      'Date selection canceled.';

  @override
  String get notificationPageTimeSelectionCanceled =>
      'Time selection canceled.';

  @override
  String get notificationPageSelectDateFirstSnackBar =>
      'Please select a date first.';

  @override
  String get notificationPageRepeatEvery => 'Repeat every';

  @override
  String get notificationPageDailyTiming => 'Daily timing';

  @override
  String get notificationPageDuration => 'Duration';

  @override
  String get notificationPageHowManyTimes => 'How many times: ';

  @override
  String get notificationPageRandomExample =>
      'e.g: Show 5 notifications at random times';

  @override
  String get notificationPageEvery => 'Every:';

  @override
  String notificationPageIntervalUnit(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'hour': 'hours',
      'minute': 'minutes',
      'other': 'ERROR!!',
    });
    return '$_temp0';
  }

  @override
  String get notificationPageIntervalExample =>
      'e.g: Show notification every 2 hours';

  @override
  String get notificationPageOccurrences => 'occurrences';

  @override
  String get notificationPageMonths => 'Months';

  @override
  String get notificationPageDays => 'Days';

  @override
  String get notificationPageMonthlyDaysNotice =>
      'If you select 29, 30 or 31, the notification will not trigger in months that do not have those days.';

  @override
  String get notificationPageFirstDayOfMonth => 'First day of month';

  @override
  String get notificationPageLastDayOfMonth => 'Last day of month';

  @override
  String get notificationPageAllTimeSlotsSelected =>
      'All daily time slots are already selected.';

  @override
  String get notificationPageDuplicateTime =>
      'This time is already selected. Choose a different time.';

  @override
  String get notificationPageSaved => 'Notification saved successfully.';

  @override
  String get notificationPageUpdated => 'Notification updated successfully.';

  @override
  String notificationPageSaveError(String error) {
    return 'Error while creating notification: $error';
  }

  @override
  String get notificationPageFrom => 'From';

  @override
  String get notificationPageUntil => 'Until';

  @override
  String get notificationPageSelectRange => 'Select range';

  @override
  String get validationTitleEmpty => 'Title cannot be empty.';

  @override
  String get validationStartDateRequired =>
      'Please select a start date and time.';

  @override
  String get validationDateInPast =>
      'Selected date and time cannot be in the past.';

  @override
  String get validationDailyTimingRequired => 'Select a daily timing method.';

  @override
  String get validationRepeatEveryInvalid =>
      '\'Repeat every\' must be a whole number greater than 0.';

  @override
  String get validationSelectDayOfWeek =>
      'Select at least one day of the week.';

  @override
  String get validationSelectDayOfMonth =>
      'Select at least one day of the month.';

  @override
  String get validationSelectMonthAndDay =>
      'Select at least one month and one day.';

  @override
  String get validationAtLeastOneTime =>
      'You must add at least one time for \'At selected times\'';

  @override
  String get validationNoDuplicateTimes =>
      'You cannot add duplicate times for \'At selected times\'';

  @override
  String get validationHowManyTimesRequired =>
      'You must set the \'How many times\' field for \'Random times\'';

  @override
  String get validationHowManyTimesNotNumber =>
      'The \'How many times\' field must be a number';

  @override
  String get validationRandomCountPositive =>
      'Number of random notifications must be greater than 0.';

  @override
  String get validationRandomWindowRequired =>
      'Select random notification start and end times.';

  @override
  String get validationRandomWindowOrder =>
      'Random times start time must be before end time.';

  @override
  String get validationRandomCountExceedsWindow =>
      'Random times notification count cannot exceed available minutes in window.';

  @override
  String get validationEveryRequired =>
      'You must set the \'Every\' field for \'At regular intervals\'';

  @override
  String get validationIntervalPositive =>
      'At regular intervals must be a whole number greater than 0.';

  @override
  String get validationIntervalUnitRequired => 'Select an interval unit.';

  @override
  String get validationIntervalWindowRequired =>
      'Select interval start and end times.';

  @override
  String get validationIntervalWindowOrder =>
      'At regular intervals start time must be before end time.';

  @override
  String get validationDurationTypeRequired => 'Select a duration type.';

  @override
  String get validationDurationUnitRequired => 'Select a duration unit.';

  @override
  String get validationDurationInvalid => 'Enter a valid duration.';

  @override
  String get validationOccurrencesInvalid =>
      'Enter valid total times occurrences.';

  @override
  String get validationEndDateRequired =>
      'Select an end date for the notification.';

  @override
  String get validationPermissionsNotGranted =>
      'Required permissions are not granted. Please enable them in settings.';

  @override
  String get validationStartBeforeEnd => 'Start time must be before end time.';

  @override
  String get permissionNotificationsTitle =>
      'Notifications Permission Required';

  @override
  String get permissionNotificationsMessage =>
      'Please allow notifications permission in settings to receive reminders.';

  @override
  String get permissionExactAlarmTitle => 'Exact Alarm Permission Required';

  @override
  String get permissionExactAlarmMessage =>
      'Please allow exact alarm permission in settings to receive reminders on time.';

  @override
  String get permissionDndTitle => 'DND Access Permission Required';

  @override
  String get permissionDndMessage =>
      'Please allow DND access permission in settings to override it.';

  @override
  String get dndSwitchTitle => 'Override Do Not Disturb';

  @override
  String get dndSwitchSubtitle => 'Bypass device DND mode';

  @override
  String get dndPillLabel => 'Bypass DND';

  @override
  String get listingSeparator => '  •  ';

  @override
  String listingScheduleOnce(String date) {
    return 'Once  •  $date';
  }

  @override
  String listingScheduleEveryUnit(String unit, String times) {
    return 'Every $unit  •  $times';
  }

  @override
  String listingScheduleEveryCount(num count, String unit, String times) {
    return 'Every $count $unit\n$times';
  }

  @override
  String listingScheduleRandom(num count, String start, String end) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count times',
      one: '$count time',
    );
    return 'Random  •  $_temp0\n$start - $end';
  }

  @override
  String listingScheduleInterval(
    num count,
    String unit,
    String start,
    String end,
  ) {
    return 'Every $count $unit\n$start - $end';
  }

  @override
  String get listingScheduleFallback => 'Scheduled notification';

  @override
  String listingDurationUntil(String date) {
    return 'Until $date';
  }

  @override
  String listingDurationRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count times',
      one: '$count time',
    );
    return 'Remaining $_temp0';
  }

  @override
  String get listingDurationLimited => 'Limited duration';

  @override
  String get listingDetailScheduled => 'Scheduled';

  @override
  String listingDetailOccurrences(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count occurrences',
      one: '$count occurrence',
    );
    return '$_temp0';
  }

  @override
  String listingDetailLastSent(String date) {
    return 'Last sent $date';
  }

  @override
  String listingDetailCreated(String date) {
    return 'Created $date';
  }

  @override
  String listingDetailUpdated(String date) {
    return 'Updated $date';
  }

  @override
  String get listingStatusActive => 'ACTIVE';

  @override
  String get listingStatusPaused => 'PAUSED';

  @override
  String get listingNotScheduled => 'Not scheduled';

  @override
  String get listingRelativeNow => 'Now';

  @override
  String get listingRelativeIn => 'in';

  @override
  String get listingRelativeAgo => 'ago';

  @override
  String listingRelativeYears(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count years',
      one: '$count year',
    );
    return '$_temp0';
  }

  @override
  String listingRelativeDays(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count days',
      one: '$count day',
    );
    return '$_temp0';
  }

  @override
  String listingRelativeHours(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count hours',
      one: '$count hour',
    );
    return '$_temp0';
  }

  @override
  String listingRelativeMinutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count mins',
      one: '$count min',
    );
    return '$_temp0';
  }

  @override
  String unitDay(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'days',
      one: 'day',
      zero: 'days',
    );
    return '$_temp0';
  }

  @override
  String unitWeek(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'weeks',
      one: 'week',
      zero: 'weeks',
    );
    return '$_temp0';
  }

  @override
  String unitMonth(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'months',
      one: 'month',
      zero: 'months',
    );
    return '$_temp0';
  }

  @override
  String unitYear(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'years',
      one: 'year',
      zero: 'years',
    );
    return '$_temp0';
  }

  @override
  String unitHour(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'hours',
      one: 'hour',
      zero: 'hours',
    );
    return '$_temp0';
  }

  @override
  String unitMinute(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'minutes',
      one: 'minute',
      zero: 'minutes',
    );
    return '$_temp0';
  }

  @override
  String get repetitionTypeOneTime => 'One-time';

  @override
  String get repetitionTypeRepetitive => 'Repetitive';

  @override
  String get recurrenceTypeSpecific => 'At selected times';

  @override
  String get recurrenceTypeRandom => 'Random times';

  @override
  String get recurrenceTypeInterval => 'At regular intervals';

  @override
  String get scheduleUnitDaily => 'Daily';

  @override
  String get scheduleUnitWeekly => 'Weekly';

  @override
  String get scheduleUnitMonthly => 'Monthly';

  @override
  String get scheduleUnitYearly => 'Yearly';

  @override
  String get scheduleUnitDay => 'Day';

  @override
  String get scheduleUnitWeek => 'Week';

  @override
  String get scheduleUnitMonth => 'Month';

  @override
  String get scheduleUnitYear => 'Year';

  @override
  String get dailyOptionAllDays => 'All days';

  @override
  String get dailyOptionWeekdays => 'Weekdays';

  @override
  String get dailyOptionWeekends => 'Weekends';

  @override
  String get durationOptionForever => 'Forever';

  @override
  String get durationOptionDuration => 'For a duration';

  @override
  String get durationOptionUntilDate => 'Until date';

  @override
  String get durationOptionOccurrences => 'For a total of N times';

  @override
  String get listingBypassDnd => 'Bypass DND';
}

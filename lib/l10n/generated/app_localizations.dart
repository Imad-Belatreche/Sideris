import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
    Locale('fr'),
  ];

  /// No description provided for @appName.
  ///
  /// In en, this message translates to:
  /// **'Sideris'**
  String get appName;

  /// No description provided for @actionUndo.
  ///
  /// In en, this message translates to:
  /// **'Undo'**
  String get actionUndo;

  /// No description provided for @actionWarning.
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get actionWarning;

  /// No description provided for @actionCancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get actionCancel;

  /// No description provided for @actionDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get actionDelete;

  /// No description provided for @actionCreate.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get actionCreate;

  /// No description provided for @actionUpdate.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get actionUpdate;

  /// No description provided for @actionSave.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get actionSave;

  /// No description provided for @actionStart.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get actionStart;

  /// No description provided for @actionOkay.
  ///
  /// In en, this message translates to:
  /// **'Okay'**
  String get actionOkay;

  /// No description provided for @actionTo.
  ///
  /// In en, this message translates to:
  /// **'to'**
  String get actionTo;

  /// No description provided for @actionAddTime.
  ///
  /// In en, this message translates to:
  /// **'Add Time'**
  String get actionAddTime;

  /// No description provided for @actionOpenSettings.
  ///
  /// In en, this message translates to:
  /// **'Open Settings'**
  String get actionOpenSettings;

  /// No description provided for @actionSelectDate.
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get actionSelectDate;

  /// No description provided for @actionSelectTime.
  ///
  /// In en, this message translates to:
  /// **'Select time'**
  String get actionSelectTime;

  /// No description provided for @actionCreateNotification.
  ///
  /// In en, this message translates to:
  /// **'Create Notification'**
  String get actionCreateNotification;

  /// No description provided for @actionUpdateNotification.
  ///
  /// In en, this message translates to:
  /// **'Update Notification'**
  String get actionUpdateNotification;

  /// No description provided for @navHome.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get navHome;

  /// No description provided for @navSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get navSettings;

  /// No description provided for @greetingMorning.
  ///
  /// In en, this message translates to:
  /// **'Good morning'**
  String get greetingMorning;

  /// No description provided for @greetingAfternoon.
  ///
  /// In en, this message translates to:
  /// **'Good afternoon'**
  String get greetingAfternoon;

  /// No description provided for @greetingEvening.
  ///
  /// In en, this message translates to:
  /// **'Good evening'**
  String get greetingEvening;

  /// No description provided for @homePageCalendarNoRules.
  ///
  /// In en, this message translates to:
  /// **'No rules planned for this day'**
  String get homePageCalendarNoRules;

  /// No description provided for @homePageCalendarRulesPlanned.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{1 rule planned} other{{count} rules planned}}'**
  String homePageCalendarRulesPlanned(num count);

  /// No description provided for @homePageCalendarTapToInspectRules.
  ///
  /// In en, this message translates to:
  /// **'Tap another day to inspect its rules.'**
  String get homePageCalendarTapToInspectRules;

  /// No description provided for @homePageListAllActive.
  ///
  /// In en, this message translates to:
  /// **'All Active Rules'**
  String get homePageListAllActive;

  /// No description provided for @homePageNotificationDeleteDialogContent.
  ///
  /// In en, this message translates to:
  /// **'This notification rule will be permanently deleted.\n\nAre you sure about that?'**
  String get homePageNotificationDeleteDialogContent;

  /// No description provided for @homePageNotificationDeleted.
  ///
  /// In en, this message translates to:
  /// **'Notification deleted'**
  String get homePageNotificationDeleted;

  /// No description provided for @settingsPageTitle.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsPageTitle;

  /// No description provided for @settingsPageLoadingError.
  ///
  /// In en, this message translates to:
  /// **'An error happened while loading settings: {errorMessage}'**
  String settingsPageLoadingError(String errorMessage);

  /// No description provided for @settingsPageTheme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get settingsPageTheme;

  /// No description provided for @settingsPageLanguage.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get settingsPageLanguage;

  /// No description provided for @settingsPageDefaultNotificationTemplate.
  ///
  /// In en, this message translates to:
  /// **'Default notification template'**
  String get settingsPageDefaultNotificationTemplate;

  /// No description provided for @settingsPageDefaultRepetition.
  ///
  /// In en, this message translates to:
  /// **'Default Repetition'**
  String get settingsPageDefaultRepetition;

  /// No description provided for @settingsPageDefaultRecurrence.
  ///
  /// In en, this message translates to:
  /// **'Default Recurrence'**
  String get settingsPageDefaultRecurrence;

  /// No description provided for @settingsPageDefaultTiming.
  ///
  /// In en, this message translates to:
  /// **'Default Timing'**
  String get settingsPageDefaultTiming;

  /// No description provided for @settingsPageDefaultDuration.
  ///
  /// In en, this message translates to:
  /// **'Default Duration'**
  String get settingsPageDefaultDuration;

  /// No description provided for @settingsPageSavedSettings.
  ///
  /// In en, this message translates to:
  /// **'Settings have been saved'**
  String get settingsPageSavedSettings;

  /// No description provided for @settingsPageDefaultDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'(Default is empty)'**
  String get settingsPageDefaultDescriptionHint;

  /// No description provided for @fieldTitle.
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get fieldTitle;

  /// No description provided for @fieldDescription.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get fieldDescription;

  /// No description provided for @notificationPageCreateTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Notification'**
  String get notificationPageCreateTitle;

  /// No description provided for @notificationPageUpdateTitle.
  ///
  /// In en, this message translates to:
  /// **'Update Notification'**
  String get notificationPageUpdateTitle;

  /// No description provided for @notificationPageTitleHint.
  ///
  /// In en, this message translates to:
  /// **'Notification title'**
  String get notificationPageTitleHint;

  /// No description provided for @notificationPageContentTitle.
  ///
  /// In en, this message translates to:
  /// **'Content (optional)'**
  String get notificationPageContentTitle;

  /// No description provided for @notificationPageContentHint.
  ///
  /// In en, this message translates to:
  /// **'Add details...'**
  String get notificationPageContentHint;

  /// No description provided for @notificationPageColorTag.
  ///
  /// In en, this message translates to:
  /// **'Color Tag'**
  String get notificationPageColorTag;

  /// No description provided for @notificationPageRepetitionType.
  ///
  /// In en, this message translates to:
  /// **'Repetition Type'**
  String get notificationPageRepetitionType;

  /// No description provided for @notificationPageOptions.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get notificationPageOptions;

  /// No description provided for @notificationPageDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Date & Time'**
  String get notificationPageDateAndTime;

  /// No description provided for @notificationPageSchedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get notificationPageSchedule;

  /// No description provided for @notificationPageStartFromNow.
  ///
  /// In en, this message translates to:
  /// **'From now'**
  String get notificationPageStartFromNow;

  /// No description provided for @notificationPagePickDateAndTime.
  ///
  /// In en, this message translates to:
  /// **'Pick date & time'**
  String get notificationPagePickDateAndTime;

  /// No description provided for @notificationPageDateSelectionCanceled.
  ///
  /// In en, this message translates to:
  /// **'Date selection canceled.'**
  String get notificationPageDateSelectionCanceled;

  /// No description provided for @notificationPageTimeSelectionCanceled.
  ///
  /// In en, this message translates to:
  /// **'Time selection canceled.'**
  String get notificationPageTimeSelectionCanceled;

  /// No description provided for @notificationPageSelectDateFirstSnackBar.
  ///
  /// In en, this message translates to:
  /// **'Please select a date first.'**
  String get notificationPageSelectDateFirstSnackBar;

  /// No description provided for @notificationPageRepeatEvery.
  ///
  /// In en, this message translates to:
  /// **'Repeat every'**
  String get notificationPageRepeatEvery;

  /// No description provided for @notificationPageDailyTiming.
  ///
  /// In en, this message translates to:
  /// **'Daily timing'**
  String get notificationPageDailyTiming;

  /// No description provided for @notificationPageDuration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get notificationPageDuration;

  /// No description provided for @notificationPageHowManyTimes.
  ///
  /// In en, this message translates to:
  /// **'How many times: '**
  String get notificationPageHowManyTimes;

  /// No description provided for @notificationPageRandomExample.
  ///
  /// In en, this message translates to:
  /// **'e.g: Show 5 notifications at random times'**
  String get notificationPageRandomExample;

  /// No description provided for @notificationPageEvery.
  ///
  /// In en, this message translates to:
  /// **'Every:'**
  String get notificationPageEvery;

  /// No description provided for @notificationPageIntervalUnit.
  ///
  /// In en, this message translates to:
  /// **'{unit, select, hour{hours} minute{minutes} other{ERROR!!}}'**
  String notificationPageIntervalUnit(String unit);

  /// No description provided for @notificationPageIntervalExample.
  ///
  /// In en, this message translates to:
  /// **'e.g: Show notification every 2 hours'**
  String get notificationPageIntervalExample;

  /// No description provided for @notificationPageOccurrences.
  ///
  /// In en, this message translates to:
  /// **'occurrences'**
  String get notificationPageOccurrences;

  /// No description provided for @notificationPageMonths.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get notificationPageMonths;

  /// No description provided for @notificationPageDays.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get notificationPageDays;

  /// No description provided for @notificationPageMonthlyDaysNotice.
  ///
  /// In en, this message translates to:
  /// **'If you select 29, 30 or 31, the notification will not trigger in months that do not have those days.'**
  String get notificationPageMonthlyDaysNotice;

  /// No description provided for @notificationPageFirstDayOfMonth.
  ///
  /// In en, this message translates to:
  /// **'First day of month'**
  String get notificationPageFirstDayOfMonth;

  /// No description provided for @notificationPageLastDayOfMonth.
  ///
  /// In en, this message translates to:
  /// **'Last day of month'**
  String get notificationPageLastDayOfMonth;

  /// No description provided for @notificationPageAllTimeSlotsSelected.
  ///
  /// In en, this message translates to:
  /// **'All daily time slots are already selected.'**
  String get notificationPageAllTimeSlotsSelected;

  /// No description provided for @notificationPageDuplicateTime.
  ///
  /// In en, this message translates to:
  /// **'This time is already selected. Choose a different time.'**
  String get notificationPageDuplicateTime;

  /// No description provided for @notificationPageSaved.
  ///
  /// In en, this message translates to:
  /// **'Notification saved successfully.'**
  String get notificationPageSaved;

  /// No description provided for @notificationPageUpdated.
  ///
  /// In en, this message translates to:
  /// **'Notification updated successfully.'**
  String get notificationPageUpdated;

  /// No description provided for @notificationPageSaveError.
  ///
  /// In en, this message translates to:
  /// **'Error while creating notification: {error}'**
  String notificationPageSaveError(String error);

  /// No description provided for @notificationPageFrom.
  ///
  /// In en, this message translates to:
  /// **'From'**
  String get notificationPageFrom;

  /// No description provided for @notificationPageUntil.
  ///
  /// In en, this message translates to:
  /// **'Until'**
  String get notificationPageUntil;

  /// No description provided for @notificationPageSelectRange.
  ///
  /// In en, this message translates to:
  /// **'Select range'**
  String get notificationPageSelectRange;

  /// No description provided for @validationTitleEmpty.
  ///
  /// In en, this message translates to:
  /// **'Title cannot be empty.'**
  String get validationTitleEmpty;

  /// No description provided for @validationStartDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Please select a start date and time.'**
  String get validationStartDateRequired;

  /// No description provided for @validationDateInPast.
  ///
  /// In en, this message translates to:
  /// **'Selected date and time cannot be in the past.'**
  String get validationDateInPast;

  /// No description provided for @validationDailyTimingRequired.
  ///
  /// In en, this message translates to:
  /// **'Select a daily timing method.'**
  String get validationDailyTimingRequired;

  /// No description provided for @validationRepeatEveryInvalid.
  ///
  /// In en, this message translates to:
  /// **'\'Repeat every\' must be a whole number greater than 0.'**
  String get validationRepeatEveryInvalid;

  /// No description provided for @validationSelectDayOfWeek.
  ///
  /// In en, this message translates to:
  /// **'Select at least one day of the week.'**
  String get validationSelectDayOfWeek;

  /// No description provided for @validationSelectDayOfMonth.
  ///
  /// In en, this message translates to:
  /// **'Select at least one day of the month.'**
  String get validationSelectDayOfMonth;

  /// No description provided for @validationSelectMonthAndDay.
  ///
  /// In en, this message translates to:
  /// **'Select at least one month and one day.'**
  String get validationSelectMonthAndDay;

  /// No description provided for @validationAtLeastOneTime.
  ///
  /// In en, this message translates to:
  /// **'You must add at least one time for \'At selected times\''**
  String get validationAtLeastOneTime;

  /// No description provided for @validationNoDuplicateTimes.
  ///
  /// In en, this message translates to:
  /// **'You cannot add duplicate times for \'At selected times\''**
  String get validationNoDuplicateTimes;

  /// No description provided for @validationHowManyTimesRequired.
  ///
  /// In en, this message translates to:
  /// **'You must set the \'How many times\' field for \'Random times\''**
  String get validationHowManyTimesRequired;

  /// No description provided for @validationHowManyTimesNotNumber.
  ///
  /// In en, this message translates to:
  /// **'The \'How many times\' field must be a number'**
  String get validationHowManyTimesNotNumber;

  /// No description provided for @validationRandomCountPositive.
  ///
  /// In en, this message translates to:
  /// **'Number of random notifications must be greater than 0.'**
  String get validationRandomCountPositive;

  /// No description provided for @validationRandomWindowRequired.
  ///
  /// In en, this message translates to:
  /// **'Select random notification start and end times.'**
  String get validationRandomWindowRequired;

  /// No description provided for @validationRandomWindowOrder.
  ///
  /// In en, this message translates to:
  /// **'Random times start time must be before end time.'**
  String get validationRandomWindowOrder;

  /// No description provided for @validationRandomCountExceedsWindow.
  ///
  /// In en, this message translates to:
  /// **'Random times notification count cannot exceed available minutes in window.'**
  String get validationRandomCountExceedsWindow;

  /// No description provided for @validationEveryRequired.
  ///
  /// In en, this message translates to:
  /// **'You must set the \'Every\' field for \'At regular intervals\''**
  String get validationEveryRequired;

  /// No description provided for @validationIntervalPositive.
  ///
  /// In en, this message translates to:
  /// **'At regular intervals must be a whole number greater than 0.'**
  String get validationIntervalPositive;

  /// No description provided for @validationIntervalUnitRequired.
  ///
  /// In en, this message translates to:
  /// **'Select an interval unit.'**
  String get validationIntervalUnitRequired;

  /// No description provided for @validationIntervalWindowRequired.
  ///
  /// In en, this message translates to:
  /// **'Select interval start and end times.'**
  String get validationIntervalWindowRequired;

  /// No description provided for @validationIntervalWindowOrder.
  ///
  /// In en, this message translates to:
  /// **'At regular intervals start time must be before end time.'**
  String get validationIntervalWindowOrder;

  /// No description provided for @validationDurationTypeRequired.
  ///
  /// In en, this message translates to:
  /// **'Select a duration type.'**
  String get validationDurationTypeRequired;

  /// No description provided for @validationDurationUnitRequired.
  ///
  /// In en, this message translates to:
  /// **'Select a duration unit.'**
  String get validationDurationUnitRequired;

  /// No description provided for @validationDurationInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid duration.'**
  String get validationDurationInvalid;

  /// No description provided for @validationOccurrencesInvalid.
  ///
  /// In en, this message translates to:
  /// **'Enter valid total times occurrences.'**
  String get validationOccurrencesInvalid;

  /// No description provided for @validationEndDateRequired.
  ///
  /// In en, this message translates to:
  /// **'Select an end date for the notification.'**
  String get validationEndDateRequired;

  /// No description provided for @validationPermissionsNotGranted.
  ///
  /// In en, this message translates to:
  /// **'Required permissions are not granted. Please enable them in settings.'**
  String get validationPermissionsNotGranted;

  /// No description provided for @validationStartBeforeEnd.
  ///
  /// In en, this message translates to:
  /// **'Start time must be before end time.'**
  String get validationStartBeforeEnd;

  /// No description provided for @permissionNotificationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Notifications Permission Required'**
  String get permissionNotificationsTitle;

  /// No description provided for @permissionNotificationsMessage.
  ///
  /// In en, this message translates to:
  /// **'Please allow notifications permission in settings to receive reminders.'**
  String get permissionNotificationsMessage;

  /// No description provided for @permissionExactAlarmTitle.
  ///
  /// In en, this message translates to:
  /// **'Exact Alarm Permission Required'**
  String get permissionExactAlarmTitle;

  /// No description provided for @permissionExactAlarmMessage.
  ///
  /// In en, this message translates to:
  /// **'Please allow exact alarm permission in settings to receive reminders on time.'**
  String get permissionExactAlarmMessage;

  /// No description provided for @permissionDndTitle.
  ///
  /// In en, this message translates to:
  /// **'DND Access Permission Required'**
  String get permissionDndTitle;

  /// No description provided for @permissionDndMessage.
  ///
  /// In en, this message translates to:
  /// **'Please allow DND access permission in settings to override it.'**
  String get permissionDndMessage;

  /// No description provided for @dndSwitchTitle.
  ///
  /// In en, this message translates to:
  /// **'Override Do Not Disturb'**
  String get dndSwitchTitle;

  /// No description provided for @dndSwitchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Bypass device DND mode'**
  String get dndSwitchSubtitle;

  /// No description provided for @dndPillLabel.
  ///
  /// In en, this message translates to:
  /// **'Bypass DND'**
  String get dndPillLabel;

  /// No description provided for @listingSeparator.
  ///
  /// In en, this message translates to:
  /// **'  •  '**
  String get listingSeparator;

  /// No description provided for @listingScheduleOnce.
  ///
  /// In en, this message translates to:
  /// **'Once  •  {date}'**
  String listingScheduleOnce(String date);

  /// No description provided for @listingScheduleEveryUnit.
  ///
  /// In en, this message translates to:
  /// **'Every {unit}  •  {times}'**
  String listingScheduleEveryUnit(String unit, String times);

  /// No description provided for @listingScheduleEveryCount.
  ///
  /// In en, this message translates to:
  /// **'Every {count} {unit}\n{times}'**
  String listingScheduleEveryCount(num count, String unit, String times);

  /// No description provided for @listingScheduleRandom.
  ///
  /// In en, this message translates to:
  /// **'Random  •  {count, plural, one{{count} time} other{{count} times}}\n{start} - {end}'**
  String listingScheduleRandom(num count, String start, String end);

  /// No description provided for @listingScheduleInterval.
  ///
  /// In en, this message translates to:
  /// **'Every {count} {unit}\n{start} - {end}'**
  String listingScheduleInterval(
    num count,
    String unit,
    String start,
    String end,
  );

  /// No description provided for @listingScheduleFallback.
  ///
  /// In en, this message translates to:
  /// **'Scheduled notification'**
  String get listingScheduleFallback;

  /// No description provided for @listingDurationUntil.
  ///
  /// In en, this message translates to:
  /// **'Until {date}'**
  String listingDurationUntil(String date);

  /// No description provided for @listingDurationRemaining.
  ///
  /// In en, this message translates to:
  /// **'Remaining {count, plural, one{{count} time} other{{count} times}}'**
  String listingDurationRemaining(num count);

  /// No description provided for @listingDurationLimited.
  ///
  /// In en, this message translates to:
  /// **'Limited duration'**
  String get listingDurationLimited;

  /// No description provided for @listingDetailScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get listingDetailScheduled;

  /// No description provided for @listingDetailOccurrences.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} occurrence} other{{count} occurrences}}'**
  String listingDetailOccurrences(num count);

  /// No description provided for @listingDetailLastSent.
  ///
  /// In en, this message translates to:
  /// **'Last sent {date}'**
  String listingDetailLastSent(String date);

  /// No description provided for @listingDetailCreated.
  ///
  /// In en, this message translates to:
  /// **'Created {date}'**
  String listingDetailCreated(String date);

  /// No description provided for @listingDetailUpdated.
  ///
  /// In en, this message translates to:
  /// **'Updated {date}'**
  String listingDetailUpdated(String date);

  /// No description provided for @listingStatusActive.
  ///
  /// In en, this message translates to:
  /// **'ACTIVE'**
  String get listingStatusActive;

  /// No description provided for @listingStatusPaused.
  ///
  /// In en, this message translates to:
  /// **'PAUSED'**
  String get listingStatusPaused;

  /// No description provided for @listingNotScheduled.
  ///
  /// In en, this message translates to:
  /// **'Not scheduled'**
  String get listingNotScheduled;

  /// No description provided for @listingRelativeNow.
  ///
  /// In en, this message translates to:
  /// **'Now'**
  String get listingRelativeNow;

  /// No description provided for @listingRelativeIn.
  ///
  /// In en, this message translates to:
  /// **'in'**
  String get listingRelativeIn;

  /// No description provided for @listingRelativeAgo.
  ///
  /// In en, this message translates to:
  /// **'ago'**
  String get listingRelativeAgo;

  /// No description provided for @listingRelativeYears.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} year} other{{count} years}}'**
  String listingRelativeYears(num count);

  /// No description provided for @listingRelativeDays.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} day} other{{count} days}}'**
  String listingRelativeDays(num count);

  /// No description provided for @listingRelativeHours.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} hour} other{{count} hours}}'**
  String listingRelativeHours(num count);

  /// No description provided for @listingRelativeMinutes.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one{{count} min} other{{count} mins}}'**
  String listingRelativeMinutes(num count);

  /// No description provided for @unitDay.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{days} one{day} other{days}}'**
  String unitDay(num count);

  /// No description provided for @unitWeek.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{weeks} one{week} other{weeks}}'**
  String unitWeek(num count);

  /// No description provided for @unitMonth.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{months} one{month} other{months}}'**
  String unitMonth(num count);

  /// No description provided for @unitYear.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{years} one{year} other{years}}'**
  String unitYear(num count);

  /// No description provided for @unitHour.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{hours} one{hour} other{hours}}'**
  String unitHour(num count);

  /// No description provided for @unitMinute.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =0{minutes} one{minute} other{minutes}}'**
  String unitMinute(num count);

  /// No description provided for @repetitionTypeOneTime.
  ///
  /// In en, this message translates to:
  /// **'One-time'**
  String get repetitionTypeOneTime;

  /// No description provided for @repetitionTypeRepetitive.
  ///
  /// In en, this message translates to:
  /// **'Repetitive'**
  String get repetitionTypeRepetitive;

  /// No description provided for @recurrenceTypeSpecific.
  ///
  /// In en, this message translates to:
  /// **'At selected times'**
  String get recurrenceTypeSpecific;

  /// No description provided for @recurrenceTypeRandom.
  ///
  /// In en, this message translates to:
  /// **'Random times'**
  String get recurrenceTypeRandom;

  /// No description provided for @recurrenceTypeInterval.
  ///
  /// In en, this message translates to:
  /// **'At regular intervals'**
  String get recurrenceTypeInterval;

  /// No description provided for @scheduleUnitDaily.
  ///
  /// In en, this message translates to:
  /// **'Daily'**
  String get scheduleUnitDaily;

  /// No description provided for @scheduleUnitWeekly.
  ///
  /// In en, this message translates to:
  /// **'Weekly'**
  String get scheduleUnitWeekly;

  /// No description provided for @scheduleUnitMonthly.
  ///
  /// In en, this message translates to:
  /// **'Monthly'**
  String get scheduleUnitMonthly;

  /// No description provided for @scheduleUnitYearly.
  ///
  /// In en, this message translates to:
  /// **'Yearly'**
  String get scheduleUnitYearly;

  /// No description provided for @scheduleUnitDay.
  ///
  /// In en, this message translates to:
  /// **'Day'**
  String get scheduleUnitDay;

  /// No description provided for @scheduleUnitWeek.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get scheduleUnitWeek;

  /// No description provided for @scheduleUnitMonth.
  ///
  /// In en, this message translates to:
  /// **'Month'**
  String get scheduleUnitMonth;

  /// No description provided for @scheduleUnitYear.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get scheduleUnitYear;

  /// No description provided for @dailyOptionAllDays.
  ///
  /// In en, this message translates to:
  /// **'All days'**
  String get dailyOptionAllDays;

  /// No description provided for @dailyOptionWeekdays.
  ///
  /// In en, this message translates to:
  /// **'Weekdays'**
  String get dailyOptionWeekdays;

  /// No description provided for @dailyOptionWeekends.
  ///
  /// In en, this message translates to:
  /// **'Weekends'**
  String get dailyOptionWeekends;

  /// No description provided for @durationOptionForever.
  ///
  /// In en, this message translates to:
  /// **'Forever'**
  String get durationOptionForever;

  /// No description provided for @durationOptionDuration.
  ///
  /// In en, this message translates to:
  /// **'For a duration'**
  String get durationOptionDuration;

  /// No description provided for @durationOptionUntilDate.
  ///
  /// In en, this message translates to:
  /// **'Until date'**
  String get durationOptionUntilDate;

  /// No description provided for @durationOptionOccurrences.
  ///
  /// In en, this message translates to:
  /// **'For a total of N times'**
  String get durationOptionOccurrences;

  /// No description provided for @listingBypassDnd.
  ///
  /// In en, this message translates to:
  /// **'Bypass DND'**
  String get listingBypassDnd;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
    case 'fr':
      return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}

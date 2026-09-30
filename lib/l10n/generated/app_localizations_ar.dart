// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'Sideris';

  @override
  String get actionUndo => 'تراجع';

  @override
  String get actionWarning => 'تحذير';

  @override
  String get actionCancel => 'إلغاء';

  @override
  String get actionDelete => 'حذف';

  @override
  String get actionCreate => 'إنشاء';

  @override
  String get actionUpdate => 'تحديث';

  @override
  String get actionSave => 'حفظ';

  @override
  String get actionStart => 'البداية';

  @override
  String get actionOkay => 'حسنًا';

  @override
  String get actionTo => 'إلى';

  @override
  String get actionAddTime => 'إضافة وقت';

  @override
  String get actionOpenSettings => 'فتح الإعدادات';

  @override
  String get actionSelectDate => 'اختر التاريخ';

  @override
  String get actionSelectTime => 'اختر الوقت';

  @override
  String get actionCreateNotification => 'إنشاء إشعار';

  @override
  String get actionUpdateNotification => 'تحديث الإشعار';

  @override
  String get navHome => 'الرئيسية';

  @override
  String get navSettings => 'الإعدادات';

  @override
  String get greetingMorning => 'صباح الخير';

  @override
  String get greetingAfternoon => 'طاب يومك';

  @override
  String get greetingEvening => 'مساء الخير';

  @override
  String get homePageCalendarNoRules => 'لا توجد قواعد مخطط لها في هذا اليوم';

  @override
  String homePageCalendarRulesPlanned(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count قاعدة مخطط لها',
      many: '$count قاعدة مخطط لها',
      few: '$count قواعد مخطط لها',
      two: 'قاعدتان مخطط لهما',
      one: 'قاعدة واحدة مخطط لها',
      zero: 'لا توجد قواعد مخطط لها',
    );
    return '$_temp0';
  }

  @override
  String get homePageCalendarTapToInspectRules =>
      'اضغط على يوم آخر لعرض قواعده.';

  @override
  String get homePageListAllActive => 'كل القواعد النشطة';

  @override
  String get homePageNotificationDeleteDialogContent =>
      'سيتم حذف قاعدة الإشعار هذه نهائيًا.\n\nهل أنت متأكد؟';

  @override
  String get homePageNotificationDeleted => 'تم حذف الإشعار';

  @override
  String get settingsPageTitle => 'الإعدادات';

  @override
  String settingsPageLoadingError(String errorMessage) {
    return 'حدث خطأ أثناء تحميل الإعدادات: $errorMessage';
  }

  @override
  String get settingsPageTheme => 'المظهر';

  @override
  String get settingsPageLanguage => 'اللغة';

  @override
  String get settingsPageDefaultNotificationTemplate =>
      'قالب الإشعار الافتراضي';

  @override
  String get settingsPageDefaultRepetition => 'التكرار الافتراضي';

  @override
  String get settingsPageDefaultRecurrence => 'الدورية الافتراضية';

  @override
  String get settingsPageDefaultTiming => 'التوقيت الافتراضي';

  @override
  String get settingsPageDefaultDuration => 'المدة الافتراضية';

  @override
  String get settingsPageSavedSettings => 'تم حفظ الإعدادات';

  @override
  String get settingsPageDefaultDescriptionHint => '(فارغ افتراضيًا)';

  @override
  String get fieldTitle => 'العنوان';

  @override
  String get fieldDescription => 'الوصف';

  @override
  String get notificationPageCreateTitle => 'إنشاء إشعار';

  @override
  String get notificationPageUpdateTitle => 'تحديث الإشعار';

  @override
  String get notificationPageTitleHint => 'عنوان الإشعار';

  @override
  String get notificationPageContentTitle => 'المحتوى (اختياري)';

  @override
  String get notificationPageContentHint => 'أضف تفاصيل...';

  @override
  String get notificationPageColorTag => 'علامة لونية';

  @override
  String get notificationPageRepetitionType => 'نوع التكرار';

  @override
  String get notificationPageOptions => 'الخيارات';

  @override
  String get notificationPageDateAndTime => 'التاريخ والوقت';

  @override
  String get notificationPageSchedule => 'الجدولة';

  @override
  String get notificationPageStartFromNow => 'من الآن';

  @override
  String get notificationPagePickDateAndTime => 'اختر التاريخ والوقت';

  @override
  String get notificationPageDateSelectionCanceled =>
      'تم إلغاء اختيار التاريخ.';

  @override
  String get notificationPageTimeSelectionCanceled => 'تم إلغاء اختيار الوقت.';

  @override
  String get notificationPageSelectDateFirstSnackBar =>
      'يرجى اختيار التاريخ أولًا.';

  @override
  String get notificationPageRepeatEvery => 'كرر كل';

  @override
  String get notificationPageDailyTiming => 'التوقيت اليومي';

  @override
  String get notificationPageDuration => 'المدة';

  @override
  String get notificationPageHowManyTimes => 'كم مرة: ';

  @override
  String get notificationPageRandomExample =>
      'مثال: إظهار 5 إشعارات في أوقات عشوائية';

  @override
  String get notificationPageEvery => 'كل';

  @override
  String notificationPageIntervalUnit(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'hour': 'ساعات',
      'minute': 'دقائق',
      'other': 'خطأ!!',
    });
    return '$_temp0';
  }

  @override
  String get notificationPageIntervalExample => 'مثال: إظهار إشعار كل ساعتين';

  @override
  String get notificationPageOccurrences => 'مرات';

  @override
  String get notificationPageMonths => 'الأشهر';

  @override
  String get notificationPageDays => 'الأيام';

  @override
  String get notificationPageMonthlyDaysNotice =>
      'إذا اخترت 29 أو 30 أو 31، فلن يظهر الإشعار في الأشهر التي لا تحتوي على تلك الأيام.';

  @override
  String get notificationPageFirstDayOfMonth => 'أول يوم من الشهر';

  @override
  String get notificationPageLastDayOfMonth => 'آخر يوم من الشهر';

  @override
  String get notificationPageAllTimeSlotsSelected =>
      'كل الأوقات اليومية محدَّدة بالفعل.';

  @override
  String get notificationPageDuplicateTime =>
      'هذا الوقت محدَّد بالفعل. اختر وقتًا آخر.';

  @override
  String get notificationPageSaved => 'تم حفظ الإشعار بنجاح.';

  @override
  String get notificationPageUpdated => 'تم تحديث الإشعار بنجاح.';

  @override
  String notificationPageSaveError(String error) {
    return 'خطأ أثناء إنشاء الإشعار: $error';
  }

  @override
  String get notificationPageFrom => 'من';

  @override
  String get notificationPageUntil => 'إلى';

  @override
  String get notificationPageSelectRange => 'حدد نطاقًا';

  @override
  String get validationTitleEmpty => 'لا يمكن أن يكون العنوان فارغًا.';

  @override
  String get validationStartDateRequired => 'يرجى تحديد تاريخ ووقت البدء.';

  @override
  String get validationDateInPast =>
      'لا يمكن أن يكون التاريخ والوقت المحدَّدان في الماضي.';

  @override
  String get validationDailyTimingRequired => 'اختر طريقة التوقيت اليومي.';

  @override
  String get validationRepeatEveryInvalid =>
      'يجب أن يكون «كرر كل» رقمًا صحيحًا أكبر من 0.';

  @override
  String get validationSelectDayOfWeek =>
      'اختر يومًا واحدًا على الأقل من أيام الأسبوع.';

  @override
  String get validationSelectDayOfMonth =>
      'اختر يومًا واحدًا على الأقل من أيام الشهر.';

  @override
  String get validationSelectMonthAndDay =>
      'اختر شهرًا واحدًا ويومًا واحدًا على الأقل.';

  @override
  String get validationAtLeastOneTime =>
      'يجب أن تضيف وقتًا واحدًا على الأقل لـ«في الأوقات المحددة»';

  @override
  String get validationNoDuplicateTimes =>
      'لا يمكنك إضافة أوقات مكررة لـ«في الأوقات المحددة»';

  @override
  String get validationHowManyTimesRequired =>
      'يجب أن تحدد حقل «كم مرة» لـ«أوقات عشوائية»';

  @override
  String get validationHowManyTimesNotNumber =>
      'يجب أن يكون حقل «كم مرة» رقمًا';

  @override
  String get validationRandomCountPositive =>
      'يجب أن يكون عدد الإشعارات العشوائية أكبر من 0.';

  @override
  String get validationRandomWindowRequired =>
      'اختر وقتَي بدء وانتهاء الإشعارات العشوائية.';

  @override
  String get validationRandomWindowOrder =>
      'يجب أن يكون وقت البدء قبل وقت الانتهاء.';

  @override
  String get validationRandomCountExceedsWindow =>
      'لا يمكن أن يتجاوز عدد الإشعارات العشوائية عدد الدقائق المتاحة في النطاق.';

  @override
  String get validationEveryRequired =>
      'يجب أن تحدد حقل «كل» لـ«بفترات منتظمة»';

  @override
  String get validationIntervalPositive =>
      'يجب أن تكون الفترة رقمًا صحيحًا أكبر من 0.';

  @override
  String get validationIntervalUnitRequired => 'اختر وحدة الفترة.';

  @override
  String get validationIntervalWindowRequired =>
      'اختر وقتَي بدء وانتهاء الفترة.';

  @override
  String get validationIntervalWindowOrder =>
      'يجب أن يكون وقت بدء الفترة قبل وقت الانتهاء.';

  @override
  String get validationDurationTypeRequired => 'اختر نوع المدة.';

  @override
  String get validationDurationUnitRequired => 'اختر وحدة المدة.';

  @override
  String get validationDurationInvalid => 'أدخل مدة صالحة.';

  @override
  String get validationOccurrencesInvalid =>
      'أدخل عددًا صالحًا لإجمالي مرات التكرار.';

  @override
  String get validationEndDateRequired => 'اختر تاريخ انتهاء للإشعار.';

  @override
  String get validationPermissionsNotGranted =>
      'لم يتم منح الأذونات المطلوبة. يرجى تفعيلها من الإعدادات.';

  @override
  String get validationStartBeforeEnd =>
      'يجب أن يكون وقت البدء قبل وقت الانتهاء.';

  @override
  String get permissionNotificationsTitle => 'إذن الإشعارات مطلوب';

  @override
  String get permissionNotificationsMessage =>
      'يرجى السماح بالإشعارات من الإعدادات لاستلام التذكيرات.';

  @override
  String get permissionExactAlarmTitle => 'إذن المنبهات الدقيقة مطلوب';

  @override
  String get permissionExactAlarmMessage =>
      'يرجى السماح بالمنبهات الدقيقة من الإعدادات لاستلام التذكيرات في وقتها.';

  @override
  String get permissionDndTitle => 'إذن الوصول إلى عدم الإزعاج مطلوب';

  @override
  String get permissionDndMessage =>
      'يرجى السماح بالوصول إلى وضع عدم الإزعاج من الإعدادات لتجاوزه.';

  @override
  String get dndSwitchTitle => 'تجاوز وضع عدم الإزعاج';

  @override
  String get dndSwitchSubtitle => 'تجاوز وضع عدم الإزعاج في الجهاز';

  @override
  String get dndPillLabel => 'تجاوز عدم الإزعاج';

  @override
  String get listingSeparator => '  •  ';

  @override
  String listingScheduleOnce(String date) {
    return 'مرة واحدة  •  $date';
  }

  @override
  String listingScheduleEveryUnit(String unit, String times) {
    return 'كل $unit  •  $times';
  }

  @override
  String listingScheduleEveryCount(num count, String unit, String times) {
    return 'كل $count $unit\n$times';
  }

  @override
  String listingScheduleRandom(num count, String start, String end) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مرة',
      many: '$count مرة',
      few: '$count مرات',
      two: 'مرتان',
      one: 'مرة واحدة',
    );
    return 'عشوائي  •  $_temp0\n$start - $end';
  }

  @override
  String listingScheduleInterval(
    num count,
    String unit,
    String start,
    String end,
  ) {
    return 'كل $count $unit\n$start - $end';
  }

  @override
  String get listingScheduleFallback => 'إشعار مجدول';

  @override
  String listingDurationUntil(String date) {
    return 'حتى $date';
  }

  @override
  String listingDurationRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count مرة',
      many: '$count مرة',
      few: '$count مرات',
      two: 'مرتان',
      one: 'مرة واحدة',
    );
    return 'متبقٍ $_temp0';
  }

  @override
  String get listingDurationLimited => 'مدة محدودة';

  @override
  String get listingDetailScheduled => 'مجدول';

  @override
  String listingDetailOccurrences(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count تكرار',
      many: '$count تكرارًا',
      few: '$count تكرارات',
      two: 'تكراران',
      one: 'تكرار واحد',
    );
    return '$_temp0';
  }

  @override
  String listingDetailLastSent(String date) {
    return 'آخر إرسال $date';
  }

  @override
  String listingDetailCreated(String date) {
    return 'أُنشئ $date';
  }

  @override
  String listingDetailUpdated(String date) {
    return 'حُدِّث $date';
  }

  @override
  String get listingStatusActive => 'نشط';

  @override
  String get listingStatusPaused => 'متوقف';

  @override
  String get listingNotScheduled => 'غير مجدول';

  @override
  String get listingRelativeNow => 'الآن';

  @override
  String get listingRelativeIn => 'بعد';

  @override
  String get listingRelativeAgo => 'منذ';

  @override
  String listingRelativeYears(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count سنة',
      many: '$count سنة',
      few: '$count سنوات',
      two: 'سنتان',
      one: 'سنة',
      zero: 'سنة',
    );
    return '$_temp0';
  }

  @override
  String listingRelativeDays(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count يوم',
      many: '$count يومًا',
      few: '$count أيام',
      two: 'يومان',
      one: 'يوم',
      zero: 'يوم',
    );
    return '$_temp0';
  }

  @override
  String listingRelativeHours(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ساعة',
      many: '$count ساعة',
      few: '$count ساعات',
      two: 'ساعتان',
      one: 'ساعة',
      zero: 'ساعة',
    );
    return '$_temp0';
  }

  @override
  String listingRelativeMinutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count دقيقة',
      many: '$count دقيقة',
      few: '$count دقائق',
      two: 'دقيقتان',
      one: 'دقيقة',
      zero: 'دقيقة',
    );
    return '$_temp0';
  }

  @override
  String unitDay(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'يوم',
      many: 'يومًا',
      few: 'أيام',
      two: 'يومان',
      one: 'يوم',
      zero: 'أيام',
    );
    return '$_temp0';
  }

  @override
  String unitWeek(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'أسبوع',
      many: 'أسبوعًا',
      few: 'أسابيع',
      two: 'أسبوعان',
      one: 'أسبوع',
      zero: 'أسابيع',
    );
    return '$_temp0';
  }

  @override
  String unitMonth(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'شهر',
      many: 'شهرًا',
      few: 'أشهر',
      two: 'شهران',
      one: 'شهر',
      zero: 'أشهر',
    );
    return '$_temp0';
  }

  @override
  String unitYear(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'سنة',
      many: 'سنة',
      few: 'سنوات',
      two: 'سنتان',
      one: 'سنة',
      zero: 'سنوات',
    );
    return '$_temp0';
  }

  @override
  String unitHour(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ساعة',
      many: 'ساعة',
      few: 'ساعات',
      two: 'ساعتان',
      one: 'ساعة',
      zero: 'ساعات',
    );
    return '$_temp0';
  }

  @override
  String unitMinute(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'دقيقة',
      many: 'دقيقة',
      few: 'دقائق',
      two: 'دقيقتان',
      one: 'دقيقة',
      zero: 'دقائق',
    );
    return '$_temp0';
  }

  @override
  String get repetitionTypeOneTime => 'مرة واحدة';

  @override
  String get repetitionTypeRepetitive => 'متكرر';

  @override
  String get recurrenceTypeSpecific => 'في الأوقات المحددة';

  @override
  String get recurrenceTypeRandom => 'أوقات عشوائية';

  @override
  String get recurrenceTypeInterval => 'بفترات منتظمة';

  @override
  String get scheduleUnitDaily => 'يومي';

  @override
  String get scheduleUnitWeekly => 'أسبوعي';

  @override
  String get scheduleUnitMonthly => 'شهري';

  @override
  String get scheduleUnitYearly => 'سنوي';

  @override
  String get scheduleUnitDay => 'يوم';

  @override
  String get scheduleUnitWeek => 'أسبوع';

  @override
  String get scheduleUnitMonth => 'شهر';

  @override
  String get scheduleUnitYear => 'سنة';

  @override
  String get dailyOptionAllDays => 'كل الأيام';

  @override
  String get dailyOptionWeekdays => 'أيام الأسبوع';

  @override
  String get dailyOptionWeekends => 'عطلة نهاية الأسبوع';

  @override
  String get durationOptionForever => 'إلى الأبد';

  @override
  String get durationOptionDuration => 'لمدة محددة';

  @override
  String get durationOptionUntilDate => 'حتى تاريخ محدد';

  @override
  String get durationOptionOccurrences => 'لإجمالي عدد من المرات';

  @override
  String get listingBypassDnd => 'تجاوز وضع عدم الإزعاج';
}

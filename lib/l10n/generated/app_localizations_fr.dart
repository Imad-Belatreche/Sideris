// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'Sideris';

  @override
  String get actionUndo => 'Annuler';

  @override
  String get actionWarning => 'Avertissement';

  @override
  String get actionCancel => 'Annuler';

  @override
  String get actionDelete => 'Supprimer';

  @override
  String get actionCreate => 'Créer';

  @override
  String get actionUpdate => 'Mettre à jour';

  @override
  String get actionSave => 'Enregistrer';

  @override
  String get actionStart => 'Début';

  @override
  String get actionOkay => 'D’accord';

  @override
  String get actionTo => 'à';

  @override
  String get actionAddTime => 'Ajouter une heure';

  @override
  String get actionOpenSettings => 'Ouvrir les paramètres';

  @override
  String get actionSelectDate => 'Choisir une date';

  @override
  String get actionSelectTime => 'Choisir une heure';

  @override
  String get actionCreateNotification => 'Créer la notification';

  @override
  String get actionUpdateNotification => 'Mettre à jour la notification';

  @override
  String get navHome => 'Accueil';

  @override
  String get navSettings => 'Paramètres';

  @override
  String get greetingMorning => 'Bonjour';

  @override
  String get greetingAfternoon => 'Bon après-midi';

  @override
  String get greetingEvening => 'Bonsoir';

  @override
  String get homePageCalendarNoRules => 'Aucune règle prévue pour ce jour';

  @override
  String homePageCalendarRulesPlanned(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count règles prévues',
      one: '1 règle prévue',
    );
    return '$_temp0';
  }

  @override
  String get homePageCalendarTapToInspectRules =>
      'Touchez un autre jour pour consulter ses règles.';

  @override
  String get homePageListAllActive => 'Toutes les règles actives';

  @override
  String get homePageNotificationDeleteDialogContent =>
      'Cette règle de notification sera définitivement supprimée.\n\nEn êtes-vous sûr ?';

  @override
  String get homePageNotificationDeleted => 'Notification supprimée';

  @override
  String get settingsPageTitle => 'Paramètres';

  @override
  String settingsPageLoadingError(String errorMessage) {
    return 'Une erreur s’est produite lors du chargement des paramètres : $errorMessage';
  }

  @override
  String get settingsPageTheme => 'Thème';

  @override
  String get settingsPageLanguage => 'Langue';

  @override
  String get settingsPageDefaultNotificationTemplate =>
      'Modèle de notification par défaut';

  @override
  String get settingsPageDefaultRepetition => 'Répétition par défaut';

  @override
  String get settingsPageDefaultRecurrence => 'Récurrence par défaut';

  @override
  String get settingsPageDefaultTiming => 'Horodatage par défaut';

  @override
  String get settingsPageDefaultDuration => 'Durée par défaut';

  @override
  String get settingsPageSavedSettings => 'Les paramètres ont été enregistrés';

  @override
  String get settingsPageDefaultDescriptionHint => '(Vide par défaut)';

  @override
  String get fieldTitle => 'Titre';

  @override
  String get fieldDescription => 'Description';

  @override
  String get notificationPageCreateTitle => 'Créer la notification';

  @override
  String get notificationPageUpdateTitle => 'Mettre à jour la notification';

  @override
  String get notificationPageTitleHint => 'Titre de la notification';

  @override
  String get notificationPageContentTitle => 'Contenu (facultatif)';

  @override
  String get notificationPageContentHint => 'Ajouter des détails...';

  @override
  String get notificationPageColorTag => 'Couleur';

  @override
  String get notificationPageRepetitionType => 'Type de répétition';

  @override
  String get notificationPageOptions => 'Options';

  @override
  String get notificationPageDateAndTime => 'Date et heure';

  @override
  String get notificationPageSchedule => 'Programmation';

  @override
  String get notificationPageStartFromNow => 'À partir de maintenant';

  @override
  String get notificationPagePickDateAndTime => 'Choisir la date et l’heure';

  @override
  String get notificationPageDateSelectionCanceled =>
      'Sélection de la date annulée.';

  @override
  String get notificationPageTimeSelectionCanceled =>
      'Sélection de l’heure annulée.';

  @override
  String get notificationPageSelectDateFirstSnackBar =>
      'Veuillez d’abord sélectionner une date.';

  @override
  String get notificationPageRepeatEvery => 'Répéter tous les';

  @override
  String get notificationPageDailyTiming => 'Horaires quotidiens';

  @override
  String get notificationPageDuration => 'Durée';

  @override
  String get notificationPageHowManyTimes => 'Combien de fois : ';

  @override
  String get notificationPageRandomExample =>
      'ex. : afficher 5 notifications à des heures aléatoires';

  @override
  String get notificationPageEvery => 'Toutes les';

  @override
  String notificationPageIntervalUnit(String unit) {
    String _temp0 = intl.Intl.selectLogic(unit, {
      'hour': 'heures',
      'minute': 'minutes',
      'other': 'Erreur !!',
    });
    return '$_temp0';
  }

  @override
  String get notificationPageIntervalExample =>
      'ex. : afficher une notification toutes les 2 heures';

  @override
  String get notificationPageOccurrences => 'occurrences';

  @override
  String get notificationPageMonths => 'Mois';

  @override
  String get notificationPageDays => 'Jours';

  @override
  String get notificationPageMonthlyDaysNotice =>
      'Si vous sélectionnez 29, 30 ou 31, la notification ne se déclenchera pas les mois ne comportant pas ces jours.';

  @override
  String get notificationPageFirstDayOfMonth => 'Premier jour du mois';

  @override
  String get notificationPageLastDayOfMonth => 'Dernier jour du mois';

  @override
  String get notificationPageAllTimeSlotsSelected =>
      'Tous les créneaux horaires de la journée sont déjà sélectionnés.';

  @override
  String get notificationPageDuplicateTime =>
      'Cette heure est déjà sélectionnée. Choisissez une autre heure.';

  @override
  String get notificationPageSaved => 'Notification enregistrée avec succès.';

  @override
  String get notificationPageUpdated => 'Notification mise à jour avec succès.';

  @override
  String notificationPageSaveError(String error) {
    return 'Erreur lors de la création de la notification : $error';
  }

  @override
  String get notificationPageFrom => 'De';

  @override
  String get notificationPageUntil => 'À';

  @override
  String get notificationPageSelectRange => 'Choisir une plage';

  @override
  String get validationTitleEmpty => 'Le titre ne peut pas être vide.';

  @override
  String get validationStartDateRequired =>
      'Veuillez sélectionner une date et une heure de début.';

  @override
  String get validationDateInPast =>
      'La date et l’heure sélectionnées ne peuvent pas être dans le passé.';

  @override
  String get validationDailyTimingRequired =>
      'Sélectionnez une méthode d’horodatage quotidien.';

  @override
  String get validationRepeatEveryInvalid =>
      '« Répéter tous les » doit être un nombre entier supérieur à 0.';

  @override
  String get validationSelectDayOfWeek =>
      'Sélectionnez au moins un jour de la semaine.';

  @override
  String get validationSelectDayOfMonth =>
      'Sélectionnez au moins un jour du mois.';

  @override
  String get validationSelectMonthAndDay =>
      'Sélectionnez au moins un mois et un jour.';

  @override
  String get validationAtLeastOneTime =>
      'Vous devez ajouter au moins une heure pour « Aux heures choisies »';

  @override
  String get validationNoDuplicateTimes =>
      'Vous ne pouvez pas ajouter d’heures en double pour « Aux heures choisies »';

  @override
  String get validationHowManyTimesRequired =>
      'Vous devez renseigner le champ « Combien de fois » pour « Heures aléatoires »';

  @override
  String get validationHowManyTimesNotNumber =>
      'Le champ « Combien de fois » doit être un nombre';

  @override
  String get validationRandomCountPositive =>
      'Le nombre de notifications aléatoires doit être supérieur à 0.';

  @override
  String get validationRandomWindowRequired =>
      'Sélectionnez les heures de début et de fin des notifications aléatoires.';

  @override
  String get validationRandomWindowOrder =>
      'L’heure de début doit être antérieure à l’heure de fin.';

  @override
  String get validationRandomCountExceedsWindow =>
      'Le nombre de notifications aléatoires ne peut pas dépasser le nombre de minutes disponibles dans la plage.';

  @override
  String get validationEveryRequired =>
      'Vous devez renseigner le champ « Toutes les » pour « À intervalles réguliers »';

  @override
  String get validationIntervalPositive =>
      'L’intervalle doit être un nombre entier supérieur à 0.';

  @override
  String get validationIntervalUnitRequired =>
      'Sélectionnez une unité d’intervalle.';

  @override
  String get validationIntervalWindowRequired =>
      'Sélectionnez les heures de début et de fin de l’intervalle.';

  @override
  String get validationIntervalWindowOrder =>
      'L’heure de début de l’intervalle doit être antérieure à l’heure de fin.';

  @override
  String get validationDurationTypeRequired => 'Sélectionnez un type de durée.';

  @override
  String get validationDurationUnitRequired =>
      'Sélectionnez une unité de durée.';

  @override
  String get validationDurationInvalid => 'Saisissez une durée valide.';

  @override
  String get validationOccurrencesInvalid =>
      'Saisissez un nombre total d’occurrences valide.';

  @override
  String get validationEndDateRequired =>
      'Sélectionnez une date de fin pour la notification.';

  @override
  String get validationPermissionsNotGranted =>
      'Les autorisations requises ne sont pas accordées. Veuillez les activer dans les paramètres.';

  @override
  String get validationStartBeforeEnd =>
      'L’heure de début doit être antérieure à l’heure de fin.';

  @override
  String get permissionNotificationsTitle =>
      'Autorisation de notification requise';

  @override
  String get permissionNotificationsMessage =>
      'Veuillez autoriser les notifications dans les paramètres pour recevoir vos rappels.';

  @override
  String get permissionExactAlarmTitle =>
      'Autorisation d’alarme exacte requise';

  @override
  String get permissionExactAlarmMessage =>
      'Veuillez autoriser les alarmes exactes dans les paramètres pour recevoir vos rappels à l’heure.';

  @override
  String get permissionDndTitle => 'Accès « Ne pas déranger » requis';

  @override
  String get permissionDndMessage =>
      'Veuillez autoriser l’accès à « Ne pas déranger » dans les paramètres pour le contourner.';

  @override
  String get dndSwitchTitle => 'Ignorer « Ne pas déranger »';

  @override
  String get dndSwitchSubtitle =>
      'Contourner le mode Ne pas déranger de l’appareil';

  @override
  String get dndPillLabel => 'DND ignoré';

  @override
  String get listingSeparator => '  •  ';

  @override
  String listingScheduleOnce(String date) {
    return 'Une fois  •  $date';
  }

  @override
  String listingScheduleEveryUnit(String unit, String times) {
    return 'Tous les $unit  •  $times';
  }

  @override
  String listingScheduleEveryCount(num count, String unit, String times) {
    return 'Tous les $count $unit\n$times';
  }

  @override
  String listingScheduleRandom(num count, String start, String end) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fois',
      one: '$count fois',
    );
    return 'Aléatoire  •  $_temp0\n$start - $end';
  }

  @override
  String listingScheduleInterval(
    num count,
    String unit,
    String start,
    String end,
  ) {
    return 'Toutes les $count $unit\n$start - $end';
  }

  @override
  String get listingScheduleFallback => 'Notification programmée';

  @override
  String listingDurationUntil(String date) {
    return 'Jusqu’au $date';
  }

  @override
  String listingDurationRemaining(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count fois',
      one: '$count fois',
    );
    return 'Encore $_temp0';
  }

  @override
  String get listingDurationLimited => 'Durée limitée';

  @override
  String get listingDetailScheduled => 'Programmée';

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
    return 'Envoyée le $date';
  }

  @override
  String listingDetailCreated(String date) {
    return 'Créée le $date';
  }

  @override
  String listingDetailUpdated(String date) {
    return 'Modifiée le $date';
  }

  @override
  String get listingStatusActive => 'ACTIVE';

  @override
  String get listingStatusPaused => 'EN PAUSE';

  @override
  String get listingNotScheduled => 'Non programmée';

  @override
  String get listingRelativeNow => 'Maintenant';

  @override
  String get listingRelativeIn => 'dans';

  @override
  String get listingRelativeAgo => 'il y a';

  @override
  String listingRelativeYears(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ans',
      one: '$count an',
    );
    return '$_temp0';
  }

  @override
  String listingRelativeDays(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count jours',
      one: '$count jour',
    );
    return '$_temp0';
  }

  @override
  String listingRelativeHours(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count heures',
      one: '$count heure',
    );
    return '$_temp0';
  }

  @override
  String listingRelativeMinutes(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count min',
      one: '$count min',
    );
    return '$_temp0';
  }

  @override
  String unitDay(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'jours',
      one: 'jour',
      zero: 'jours',
    );
    return '$_temp0';
  }

  @override
  String unitWeek(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'semaines',
      one: 'semaine',
      zero: 'semaines',
    );
    return '$_temp0';
  }

  @override
  String unitMonth(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'mois',
      one: 'mois',
      zero: 'mois',
    );
    return '$_temp0';
  }

  @override
  String unitYear(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'ans',
      one: 'an',
      zero: 'ans',
    );
    return '$_temp0';
  }

  @override
  String unitHour(num count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'heures',
      one: 'heure',
      zero: 'heures',
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
  String get repetitionTypeOneTime => 'Une seule fois';

  @override
  String get repetitionTypeRepetitive => 'Récurrente';

  @override
  String get recurrenceTypeSpecific => 'Aux heures choisies';

  @override
  String get recurrenceTypeRandom => 'Heures aléatoires';

  @override
  String get recurrenceTypeInterval => 'À intervalles réguliers';

  @override
  String get scheduleUnitDaily => 'Quotidien';

  @override
  String get scheduleUnitWeekly => 'Hebdomadaire';

  @override
  String get scheduleUnitMonthly => 'Mensuel';

  @override
  String get scheduleUnitYearly => 'Annuel';

  @override
  String get scheduleUnitDay => 'Jour';

  @override
  String get scheduleUnitWeek => 'Semaine';

  @override
  String get scheduleUnitMonth => 'Mois';

  @override
  String get scheduleUnitYear => 'Année';

  @override
  String get dailyOptionAllDays => 'Tous les jours';

  @override
  String get dailyOptionWeekdays => 'Jours de semaine';

  @override
  String get dailyOptionWeekends => 'Week-ends';

  @override
  String get durationOptionForever => 'Indéfiniment';

  @override
  String get durationOptionDuration => 'Pour une durée';

  @override
  String get durationOptionUntilDate => 'Jusqu’à une date';

  @override
  String get durationOptionOccurrences => 'Pour un total de N fois';

  @override
  String get listingBypassDnd => 'Ignorer le mode Ne pas déranger';
}

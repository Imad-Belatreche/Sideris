import 'package:equatable/equatable.dart';
import 'package:sideris/models/notification_rule_model.dart';

enum UiLanguage {
  english(value: 'en_US', label: 'English'),
  arabic(value: 'ar_DZ', label: 'العربية'),
  french(value: 'fr_FR', label: 'Français');

  final String value;
  final String label;

  static UiLanguage? fromString(String? name) {
    if (name == null) return null;
    try {
      return UiLanguage.values.byName(name);
    } on ArgumentError {
      return null;
    }
  }

  const UiLanguage({required this.value, required this.label});
}

//TODO: Add time settings later too.
class SettingsModel extends Equatable {
  final UiLanguage uiLanguage;
  final String defaultTitle;
  final String defaultDescription;
  final RepetitionType repetitionType;
  final RecurrenceType recurrenceType;

  final ScheduleUnit scheduleUnit;

  final DurationOption durationOption;
  final ColorTag? colorTag;
  final bool bypassDND;

  const SettingsModel({
    required this.uiLanguage,
    required this.defaultTitle,
    required this.defaultDescription,
    required this.repetitionType,
    required this.recurrenceType,
    required this.colorTag,
    required this.bypassDND,
    required this.scheduleUnit,
    required this.durationOption,
  });

  factory SettingsModel.initial() {
    return SettingsModel(
      uiLanguage: UiLanguage.english,
      defaultTitle: "Remind me",
      defaultDescription: "",
      repetitionType: RepetitionType.oneTime,
      recurrenceType: RecurrenceType.specific,
      colorTag: null,
      bypassDND: false,
      scheduleUnit: ScheduleUnit.daily,
      durationOption: DurationOption.forever,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "uiLanguage": uiLanguage.name,
      "defaultTitle": defaultTitle,
      "defaultDescription": defaultDescription,
      "repetitionType": repetitionType.name,
      "recurrenceType": recurrenceType.name,
      "scheduleUnit": scheduleUnit.name,

      "colorTag": colorTag?.name ?? "none",
      "bypassDND": bypassDND,
      "durationOption": durationOption.name,
    };
  }

  factory SettingsModel.fromMap(Map<String, dynamic> map) {
    final defaultSettings = SettingsModel.initial();

    return SettingsModel(
      uiLanguage:
          UiLanguage.fromString(map["uiLanguage"]) ??
          defaultSettings.uiLanguage,
      defaultTitle: map["defaultTitle"] ?? defaultSettings.defaultTitle,
      defaultDescription:
          map["defaultDescription"] ?? defaultSettings.defaultDescription,
      repetitionType:
          RepetitionType.fromString(map["repetitionType"]) ??
          defaultSettings.repetitionType,
      recurrenceType:
          RecurrenceType.fromString(map["recurrenceType"]) ??
          defaultSettings.recurrenceType,
      scheduleUnit:
          ScheduleUnit.fromString(map["scheduleUnit"]) ??
          defaultSettings.scheduleUnit,

      durationOption:
          DurationOption.fromString(map["durationOption"]) ??
          defaultSettings.durationOption,
      colorTag:
          ColorTag.fromString(map["colorTag"]) ?? defaultSettings.colorTag,
      bypassDND: map["bypassDND"] ?? defaultSettings.bypassDND,
    );
  }

  @override
  List<Object?> get props => [
    uiLanguage,
    defaultTitle,
    defaultDescription,
    repetitionType,
    recurrenceType,
    colorTag,
    bypassDND,
    scheduleUnit,
    durationOption,
  ];

  @override
  bool get stringify => true;
}

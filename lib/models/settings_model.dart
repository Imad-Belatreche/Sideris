enum UiLanguage {
  english('en_US'),
  arabic('ar_DZ'),
  french('fr_FR');

  final String value;
  const UiLanguage(this.value);
}

//TODO: Add time settings later too.
class SettingsModel {
  final UiLanguage uiLanguage;
  final String defaultTitle;
  final String defaultDescription;

  SettingsModel({
    required this.uiLanguage,
    required this.defaultTitle,
    required this.defaultDescription,
  });
}

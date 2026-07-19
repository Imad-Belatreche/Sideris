import 'package:dakerni/models/settings_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsRepository {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync(
    options: SharedPreferencesOptions(),
  );

  Future<void> saveSettings(SettingsModel settings) async {
    await Future.wait([
      prefs.setString('uiLanguage', settings.uiLanguage.name),
      prefs.setString('defaultTitle', settings.defaultTitle),
      prefs.setString('defaultDescription', settings.defaultDescription),
    ]);
  }

  Future<SettingsModel> getCurrentSettings() async {
    final [
      uiLanguageStr,
      defaultTitle,
      defaultDescription,
    ] = await Future.wait([
      prefs.getString('uiLanguage'),
      prefs.getString('defaultTitle'),
      prefs.getString('defaultDescription'),
    ]);

    final uiLanguage = uiLanguageStr != null
        ? UiLanguage.values.byName(uiLanguageStr)
        : UiLanguage.english;

    return SettingsModel(
      uiLanguage: uiLanguage,
      defaultTitle: defaultTitle ?? "Remind me",
      defaultDescription: defaultDescription ?? "",
    );
  }

  Future<void> resetSettingsToDefault() async {
    await Future.wait([
      prefs.setString('uiLanguage', UiLanguage.english.name),
      prefs.setString('defaultTitle', "Remind me"),
      prefs.setString('defaultDescription', ""),
    ]);
  }
}

import 'package:shared_preferences/shared_preferences.dart';
import 'package:sideris/models/settings_model.dart';

class SettingsRepository {
  final SharedPreferencesAsync prefs;

  SettingsRepository({SharedPreferencesAsync? prefs})
    : prefs =
          prefs ?? SharedPreferencesAsync(options: SharedPreferencesOptions());

  Future saveSettings(Map settings) async {
    final List<Future> futures = [];

    settings.forEach((key, value) {
      if (value == null) return;
      if (value is bool) {
        futures.add(prefs.setBool(key, value));
      } else if (value is String) {
        futures.add(prefs.setString(key, value));
      } else if (value is int) {
        futures.add(prefs.setInt(key, value));
      } else if (value is double) {
        futures.add(prefs.setDouble(key, value));
      } else if (value is List) {
        futures.add(
          prefs.setStringList(key, value.map((e) => e.toString()).toList()),
        );
      } else {
        throw ArgumentError(
          'Unsupported type ${value.runtimeType} for key: $key in SharedPreferencesAsync',
        );
      }
    });

    await Future.wait(futures);
  }

  Future<SettingsModel> loadSettings() async {
    final [
      uiLanguage,
      defaultTitle,
      defaultDescription,
      repetitionType,
      recurrenceType,
      colorTag,
      bypassDND,
      scheduleUnit,
      durationOption,
    ] = await Future.wait([
      prefs.getString("uiLanguage"),
      prefs.getString("defaultTitle"),
      prefs.getString("defaultDescription"),
      prefs.getString("repetitionType"),
      prefs.getString("recurrenceType"),
      prefs.getString("colorTag"),
      prefs.getBool("bypassDND"),
      prefs.getString("scheduleUnit"),
      prefs.getString("durationOption"),
    ]);

    return SettingsModel.fromMap({
      "uiLanguage": uiLanguage,
      "defaultTitle": defaultTitle,
      "defaultDescription": defaultDescription,
      "repetitionType": repetitionType,
      "recurrenceType": recurrenceType,
      "colorTag": colorTag,
      "bypassDND": bypassDND,
      "scheduleUnit": scheduleUnit,
      "durationOption": durationOption,
    });
  }

  Future<void> resetSettingsToDefault() async {
    final defaultSettings = SettingsModel.initial();

    await saveSettings(defaultSettings.toMap());
  }
}

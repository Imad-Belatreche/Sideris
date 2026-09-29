import 'package:shared_preferences/shared_preferences.dart';
import 'package:sideris/models/settings_model.dart';

class SettingsRepository {
  final SharedPreferencesAsync _prefs;

  SettingsRepository({SharedPreferencesAsync? prefs})
    : _prefs =
          prefs ?? SharedPreferencesAsync(options: SharedPreferencesOptions());

  Future saveSettings(Map settings) async {
    final List<Future> futures = [];

    settings.forEach((key, value) {
      if (value == null) return;
      if (value is bool) {
        futures.add(_prefs.setBool(key, value));
      } else if (value is String) {
        futures.add(_prefs.setString(key, value));
      } else if (value is int) {
        futures.add(_prefs.setInt(key, value));
      } else if (value is double) {
        futures.add(_prefs.setDouble(key, value));
      } else if (value is List) {
        futures.add(
          _prefs.setStringList(key, value.map((e) => e.toString()).toList()),
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
      _prefs.getString("uiLanguage"),
      _prefs.getString("defaultTitle"),
      _prefs.getString("defaultDescription"),
      _prefs.getString("repetitionType"),
      _prefs.getString("recurrenceType"),
      _prefs.getString("colorTag"),
      _prefs.getBool("bypassDND"),
      _prefs.getString("scheduleUnit"),
      _prefs.getString("durationOption"),
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

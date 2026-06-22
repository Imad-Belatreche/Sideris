import 'package:dakerni/models/settings_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'settings_state.dart';

//TODO: Think about adding a method of resetting settings to default
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit()
    : super(
        SettingsState(
          isLoading: false,
          isInitialized: false,
          settings: SettingsModel(
            uiLanguage: UiLanguage.english,
            defaultTitle: "Remind me",
            defaultDescription: "",
          ),
        ),
      ) {
    getCurrentSettings();
  }
  final SharedPreferencesAsync prefs = SharedPreferencesAsync(
    options: SharedPreferencesOptions(),
  );

  Future<void> saveSettings(SettingsModel settings) async {
    emit(state.copyWith(isLoading: true));
    try {
      await Future.wait([
        prefs.setString('uiLanguage', settings.uiLanguage.name),
        prefs.setString('defaultTitle', settings.defaultTitle),
        prefs.setString('defaultDescription', settings.defaultDescription),
      ]);

      emit(state.copyWith(settings: settings, isLoading: false));
    } catch (e) {
      final error = SettingsCubitException(e.toString());
      emit(state.copyWith(errorMessage: error.message, isLoading: false));
    }
  }

  Future<void> getCurrentSettings() async {
    emit(state.copyWith(isLoading: true));
    try {
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

      emit(
        state.copyWith(
          settings: SettingsModel(
            uiLanguage: uiLanguage,
            defaultTitle: defaultTitle ?? state.settings.defaultTitle,
            defaultDescription:
                defaultDescription ?? state.settings.defaultDescription,
          ),
          isLoading: false,
          isInitialized: true,
        ),
      );
    } catch (e) {
      final error = SettingsCubitException(e.toString());
      emit(state.copyWith(errorMessage: error.message, isLoading: false));
    }
  }
}

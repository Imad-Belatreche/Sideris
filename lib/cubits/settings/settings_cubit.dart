import 'package:sideris/models/settings_model.dart';
import 'package:sideris/repositories/settings_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'settings_state.dart';

//TODO: Think about adding a method of resetting settings to default
class SettingsCubit extends Cubit<SettingsState> {
  SettingsCubit({required SettingsRepository settingsRepository})
    : _settingsRepository = settingsRepository,
      super(
        SettingsState(
          isLoading: false,
          isInitialized: false,
          settings: SettingsModel.initial(),
        ),
      ) {
    getCurrentSettings();
  }

  final SettingsRepository _settingsRepository;

  Future<void> saveSettings(SettingsModel settings) async {
    emit(state.copyWith(isLoading: true));
    try {
      await _settingsRepository.saveSettings(settings.toMap());

      final savedSettings = await _settingsRepository.loadSettings();

      emit(state.copyWith(settings: savedSettings, isLoading: false));
    } catch (e) {
      final error = SettingsCubitException(e.toString());
      emit(state.copyWith(errorMessage: error.message, isLoading: false));
    }
  }

  Future<void> getCurrentSettings() async {
    emit(state.copyWith(isLoading: true));
    try {
      final currentSettings = await _settingsRepository.loadSettings();
      emit(
        state.copyWith(
          settings: currentSettings,
          isLoading: false,
          isInitialized: true,
        ),
      );
    } catch (e) {
      final error = SettingsCubitException(e.toString());
      emit(state.copyWith(errorMessage: error.message, isLoading: false));
    }
  }

  Future<void> resetSettingsToDefault() async {
    emit(state.copyWith(isLoading: true));

    try {
      await _settingsRepository.resetSettingsToDefault();

      final defaultSettings = await _settingsRepository.loadSettings();
      emit(state.copyWith(settings: defaultSettings, isLoading: false));
    } catch (e) {
      final error = SettingsCubitException(e.toString());
      emit(state.copyWith(errorMessage: error.message, isLoading: false));
    }
  }
}

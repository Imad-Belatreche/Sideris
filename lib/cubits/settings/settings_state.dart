part of 'settings_cubit.dart';

class SettingsCubitException implements Exception {
  final String message;

  SettingsCubitException([this.message = 'An error occurred.']);

  @override
  String toString() => 'SettingsCubitException: $message';
}

final class SettingsState {
  final bool isLoading;
  final bool isInitialized;
  final String? errorMessage;
  final SettingsModel settings;

  SettingsState({
    required this.settings,
    required this.isLoading,
    this.errorMessage,
    required this.isInitialized,
  });

  SettingsState copyWith({
    SettingsModel? settings,
    bool? isLoading,
    bool? isInitialized,
    String? errorMessage,
  }) {
    return SettingsState(
      settings: settings ?? this.settings,
      errorMessage: errorMessage ?? this.errorMessage,
      isLoading: isLoading ?? this.isLoading,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }
}

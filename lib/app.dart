import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/cubits/local/locale_cubit.dart';
import 'package:sideris/cubits/notification/notification_cubit.dart';
import 'package:sideris/cubits/settings/settings_cubit.dart';
import 'package:sideris/l10n/app_font.dart';
import 'package:sideris/l10n/l10n.dart';
import 'package:sideris/models/settings_model.dart';
import 'package:sideris/pages/main_page.dart';
import 'package:sideris/repositories/notifications_repository.dart';
import 'package:sideris/repositories/scheduled_notifications_repository.dart';
import 'package:sideris/repositories/settings_repository.dart';
import 'package:sideris/services/notification_service.dart';
import 'package:sideris/themes/app_theme.dart';
import 'package:sideris/themes/night_blue_theme.dart';

class MyApp extends StatelessWidget {
  final SettingsRepository settingsRepository;
  final NotificationsRepository notificationRepository;
  final SchedulesRepository schedulesRepository;
  final NotificationService notificationService;
  final SettingsModel initialSettings;

  const MyApp({
    super.key,
    required this.notificationRepository,
    required this.schedulesRepository,
    required this.notificationService,
    required this.settingsRepository,
    required this.initialSettings,
  });

  @override
  Widget build(BuildContext context) {
    final currentLocal = Locale(initialSettings.uiLanguage.value);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LocaleCubit(locale: currentLocal)),
        BlocProvider(
          create: (context) => NotificationCubit(
            schedulesRepository: schedulesRepository,
            notificationRepository: notificationRepository,
            notificationService: notificationService,
          ),
        ),
        BlocProvider(
          create: (context) => SettingsCubit(
            settingsRepository: settingsRepository,
            initialSettings: initialSettings,
          ),
        ),
      ],

      child: BlocBuilder<LocaleCubit, LocaleState>(
        buildWhen: (previous, current) => previous != current,
        builder: (context, state) {
          final font = appFontOfLocale(state.locale);
          final appTheme = NightBlueTheme(font: font);

          return AppThemeScope(
            theme: appTheme,
            child: MaterialApp(
              title: lookupAppLocalizations(state.locale).appName,
              theme: appTheme.data,
              localizationsDelegates: [
                AppLocalizations.delegate,
                ...GlobalMaterialLocalizations.delegates,
              ],
              supportedLocales: [Locale("en"), Locale("fr"), Locale("ar")],
              locale: state.locale,
              home: MainPage(notificationService: notificationService),
            ),
          );
        },
      ),
    );
  }
}

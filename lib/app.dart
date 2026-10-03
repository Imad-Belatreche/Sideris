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
import 'package:sideris/repositories/settings_repository.dart';
import 'package:sideris/services/notification_service.dart';

class MyApp extends StatelessWidget {
  final SettingsRepository settingsRepository;
  final NotificationsRepository notificationRepository;
  final NotificationService notificationService;
  final SettingsModel initialSettings;

  const MyApp({
    super.key,
    required this.notificationRepository,
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
            repository: notificationRepository,
            service: notificationService,
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

          return MaterialApp(
            title: lookupAppLocalizations(state.locale).appName,
            theme: ThemeData.dark().copyWith(
              textTheme: TextTheme(
                headlineLarge: font(
                  fontSize: 23,
                  fontWeight: FontWeight.w600,
                  color: Colors.white30,
                ),
                headlineSmall: font(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                  color: Colors.white70,
                ),
                labelLarge: font(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                ),
                labelMedium: font(
                  fontSize: 11,
                  fontWeight: FontWeight.w400,
                  color: Colors.white54,
                ),
                bodyMedium: font(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white,
                ),
                bodySmall: font(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: Colors.white24,
                ),
              ),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                shape: CircleBorder(),
                backgroundColor: Colors.indigo,
                elevation: 5,
                iconSize: 30,
              ),
              datePickerTheme: DatePickerThemeData(
                backgroundColor: const Color.fromARGB(255, 27, 14, 49),
              ),
              timePickerTheme: TimePickerThemeData(
                backgroundColor: const Color.fromARGB(255, 27, 14, 49),
                dialBackgroundColor: const Color.fromARGB(255, 61, 32, 112),
              ),
            ),
            localizationsDelegates: [
              AppLocalizations.delegate,
              ...GlobalMaterialLocalizations.delegates,
            ],
            supportedLocales: [Locale("en"), Locale("fr"), Locale("ar")],
            locale: state.locale,

            home: MainPage(notificationService: notificationService),
          );
        },
      ),
    );
  }
}

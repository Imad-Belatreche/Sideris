import 'package:material_ui/material_ui.dart';
import 'package:sideris/themes/app_theme.dart';
import 'package:sideris/widgets/backgrounds/day_sky_background.dart';

class DayLightTheme extends AppTheme {
  DayLightTheme({required super.font});

  @override
  String get name => "Daylight";

  @override
  IconData get icon => Icons.cloud;

  @override
  AppColors get colors => dayBlueColors;

  @override
  ThemeData get data {
    final scheme =
        ColorScheme.fromSeed(
          seedColor: colors.accent,
          brightness: Brightness.light,
        ).copyWith(
          primary: colors.accent,
          onPrimary: Colors.white,
          primaryContainer: colors.primaryAction,
          onPrimaryContainer: colors.textPrimary,
          secondary: colors.selection,
          onSecondary: Colors.white,
          secondaryContainer: colors.selection.withValues(alpha: 0.18),
          onSecondaryContainer: colors.textPrimary,
          tertiary: colors.info,
          onTertiary: Colors.white,
          error: colors.danger,
          onError: Colors.white,
          surface: colors.dialogBackground,
          onSurface: colors.textPrimary,
          surfaceTint: colors.accent,
          outline: colors.borderTint.withValues(alpha: 0.45),
          outlineVariant: colors.borderTint.withValues(alpha: 0.18),
        );

    return ThemeData.light().copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: colors.backgroundBottom,
      textTheme: buildTextTheme(),
      extensions: [colors],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: const CircleBorder(),
        backgroundColor: colors.accent,
        foregroundColor: Colors.white,
        elevation: 4,
        iconSize: 30,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(foregroundColor: colors.textPrimary),
      ),
      datePickerTheme: DatePickerThemeData(
        backgroundColor: colors.datePickerBackground,
      ),
      timePickerTheme: TimePickerThemeData(
        backgroundColor: colors.timePickerBackground,
        dialBackgroundColor: colors.timePickerDialBackground,
      ),
    );
  }

  @override
  Widget buildBackground(Widget child) => DaySkyBackground(child: child);
}

final AppColors dayBlueColors = AppColors(
  brightness: Brightness.light,
  backgroundTop: Colors.blue.shade200,
  backgroundMid: Colors.blue.shade100,
  backgroundBottom: Colors.grey.shade50,

  textPrimary: Colors.blueGrey.shade900,

  surfaceTint: Colors.white,

  borderTint: Colors.blueGrey.shade800,
  cardSurface: Colors.white70,

  accent: Colors.indigoAccent.shade400,
  accentBright: Colors.indigoAccent.shade200,
  primaryAction: Colors.indigo.shade200,

  selection: Colors.blue.shade700,
  selectionBorder: Colors.indigo.shade300,
  selectionStrong: Colors.indigo.shade700,
  selectionBright: Colors.blue.shade500,
  selectionDeep: Colors.blue.shade900,

  info: Colors.lightBlue.shade700,
  success: Colors.green.shade800,
  onSuccess: Colors.white,
  danger: Colors.red.shade600,
  shadow: Colors.black12,

  dialogBackground: Colors.white,
  datePickerBackground: Colors.grey.shade50,
  timePickerBackground: Colors.grey.shade50,
  timePickerDialBackground: Colors.blue.shade50,

  star: Colors.white70,
);

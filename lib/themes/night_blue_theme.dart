import 'package:material_ui/material_ui.dart';
import 'package:sideris/themes/app_theme.dart';
import 'package:sideris/widgets/night_sky_background.dart';

class NightBlueTheme extends AppTheme {
  NightBlueTheme({required super.font});

  @override
  AppColors get colors => nightBlueColors;

  @override
  ThemeData get data {
    return ThemeData.dark().copyWith(
      textTheme: buildTextTheme(),
      extensions: [colors],
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        shape: const CircleBorder(),
        backgroundColor: colors.accent,
        elevation: 5,
        iconSize: 30,
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
  Widget buildBackground(Widget child) => NightSkyBackground(child: child);
}

final AppColors nightBlueColors = AppColors(
  backgroundTop: const Color(0xFF03071E),
  backgroundMid: const Color(0xFF0B091A),
  backgroundBottom: const Color(0xFF161233),

  textPrimary: Colors.white,
  surfaceTint: Colors.white,
  borderTint: Colors.white,

  accent: Colors.indigo,
  accentBright: Colors.indigoAccent,
  primaryAction: const Color.fromARGB(255, 95, 12, 128),

  selection: Colors.blue,
  selectionBorder: Colors.blueAccent,
  selectionStrong: Colors.blueAccent.shade700,
  selectionBright: Colors.blueAccent.shade400,
  selectionDeep: Colors.blue.shade600,

  info: Colors.lightBlueAccent,
  success: Colors.greenAccent,
  onSuccess: Colors.black,
  danger: Colors.red,
  shadow: Colors.black12,

  dialogBackground: const Color.fromARGB(255, 38, 7, 75),
  datePickerBackground: const Color.fromARGB(255, 27, 14, 49),
  timePickerBackground: const Color.fromARGB(255, 27, 14, 49),
  timePickerDialBackground: const Color.fromARGB(255, 61, 32, 112),

  star: Colors.white,
);

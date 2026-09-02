import 'package:material_ui/material_ui.dart';

const _cyberRed = Color.fromARGB(255, 171, 0, 0);
const _deepBlack = Color.fromARGB(255, 20, 0, 0);
const _pureWhite = Colors.white;

final colorScheme = ColorScheme.fromSeed(
  primary: _cyberRed,
  onPrimary: _pureWhite,
  secondary: _pureWhite,
  onSecondary: _deepBlack,
  surface: _deepBlack,
  onSurface: _pureWhite,
  seedColor: const Color.fromARGB(255, 61, 0, 1),
  brightness: Brightness.dark,
);

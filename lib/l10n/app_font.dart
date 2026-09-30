import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

typedef AppFont =
    TextStyle Function({
      TextStyle? textStyle,
      Color? color,
      double? fontSize,
      FontWeight? fontWeight,
      FontStyle? fontStyle,
      double? letterSpacing,
      double? wordSpacing,
      TextBaseline? textBaseline,
      double? height,
      Locale? locale,
      TextDecoration? decoration,
      Color? decorationColor,
      TextDecorationStyle? decorationStyle,
      double? decorationThickness,
    });

const Set<String> rtlLanguageCodes = {
  'ar',
  'dv',
  'fa',
  'he',
  'ku',
  'ps',
  'sd',
  'ur',
  'yi',
};

AppFont appFontOf(BuildContext context) =>
    Directionality.of(context) == TextDirection.rtl
    ? GoogleFonts.cairo
    : GoogleFonts.outfit;

AppFont appFontOfLocale(Locale locale) =>
    rtlLanguageCodes.contains(locale.languageCode)
    ? GoogleFonts.cairo
    : GoogleFonts.outfit;

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

bool isRTL(Locale locale) {
  return rtlLanguageCodes.contains(locale.languageCode);
}

AppFont appFontOf(BuildContext context) =>
    Directionality.of(context) == TextDirection.rtl
    ? GoogleFonts.cairo
    : GoogleFonts.outfit;

AppFont appFontOfLocale(Locale locale) =>
    isRTL(locale) ? GoogleFonts.cairo : GoogleFonts.outfit;

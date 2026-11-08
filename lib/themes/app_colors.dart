import 'package:material_ui/material_ui.dart';

class AppColors extends ThemeExtension<AppColors> {
  final Color backgroundTop;
  final Color backgroundMid;
  final Color backgroundBottom;

  final Color textPrimary;
  final Color surfaceTint;
  final Color borderTint;

  final Color accent;
  final Color accentBright;
  final Color primaryAction;

  final Color selection;
  final Color selectionBorder;
  final Color selectionStrong;
  final Color selectionBright;
  final Color selectionDeep;

  final Color info;
  final Color success;
  final Color onSuccess;
  final Color danger;
  final Color shadow;

  final Color dialogBackground;
  final Color datePickerBackground;
  final Color timePickerBackground;
  final Color timePickerDialBackground;

  final Color star;

  AppColors({
    required this.backgroundTop,
    required this.backgroundMid,
    required this.backgroundBottom,
    required this.textPrimary,
    required this.surfaceTint,
    required this.borderTint,
    required this.accent,
    required this.accentBright,
    required this.primaryAction,
    required this.selection,
    required this.selectionBorder,
    required this.selectionStrong,
    required this.selectionBright,
    required this.selectionDeep,
    required this.info,
    required this.success,
    required this.onSuccess,
    required this.danger,
    required this.shadow,
    required this.dialogBackground,
    required this.datePickerBackground,
    required this.timePickerBackground,
    required this.timePickerDialBackground,
    required this.star,
  });

  // Text hierarchy derived from the theme's main text color.
  Color get textSecondary => textPrimary.withValues(alpha: 0.7); // white70
  Color get textTertiary => textPrimary.withValues(alpha: 0.6); // white60
  Color get textMuted => textPrimary.withValues(alpha: 0.54); // white54
  Color get textSubtle => textPrimary.withValues(alpha: 0.38); // white38
  Color get textFaint => textPrimary.withValues(alpha: 0.30); // white30
  Color get textDisabled => textPrimary.withValues(alpha: 0.24); // white24

  // Surfaces.
  Color get surface => surfaceTint.withValues(alpha: 0.1); // white10
  Color get surfaceLow => surfaceTint.withValues(alpha: 0.04);
  Color get surfaceGhost => surfaceTint.withValues(alpha: 0.012);
  Color get surfaceFaint => surfaceTint.withValues(alpha: 0.004);
  Color get surfaceOverlay => surfaceTint.withValues(alpha: 0.1);
  Color get fieldFill => surfaceTint.withValues(alpha: 0.05);

  // Borders.
  Color get borderSubtle => borderTint.withValues(alpha: 0.1); // white10
  Color get borderSoft => borderTint.withValues(alpha: 0.12); // white12
  Color get borderStrong => borderTint.withValues(alpha: 0.24); // white24

  // Accent/selection variants.
  Color get accentSoft => accent.withValues(alpha: 0.2);
  Color get selectionBackground => selection.withValues(alpha: 0.1);
  Color get selectionOverlay => selection.withValues(alpha: 0.3);

  @override
  AppColors copyWith({
    Color? backgroundTop,
    Color? backgroundMid,
    Color? backgroundBottom,
    Color? textPrimary,
    Color? surfaceTint,
    Color? borderTint,
    Color? accent,
    Color? accentBright,
    Color? primaryAction,
    Color? selection,
    Color? selectionBorder,
    Color? selectionStrong,
    Color? selectionBright,
    Color? selectionDeep,
    Color? info,
    Color? success,
    Color? onSuccess,
    Color? danger,
    Color? shadow,
    Color? dialogBackground,
    Color? datePickerBackground,
    Color? timePickerBackground,
    Color? timePickerDialBackground,
    Color? star,
  }) {
    return AppColors(
      backgroundTop: backgroundTop ?? this.backgroundTop,
      backgroundMid: backgroundMid ?? this.backgroundMid,
      backgroundBottom: backgroundBottom ?? this.backgroundBottom,
      textPrimary: textPrimary ?? this.textPrimary,
      surfaceTint: surfaceTint ?? this.surfaceTint,
      borderTint: borderTint ?? this.borderTint,
      accent: accent ?? this.accent,
      accentBright: accentBright ?? this.accentBright,
      primaryAction: primaryAction ?? this.primaryAction,
      selection: selection ?? this.selection,
      selectionBorder: selectionBorder ?? this.selectionBorder,
      selectionStrong: selectionStrong ?? this.selectionStrong,
      selectionBright: selectionBright ?? this.selectionBright,
      selectionDeep: selectionDeep ?? this.selectionDeep,
      info: info ?? this.info,
      success: success ?? this.success,
      onSuccess: onSuccess ?? this.onSuccess,
      danger: danger ?? this.danger,
      shadow: shadow ?? this.shadow,
      dialogBackground: dialogBackground ?? this.dialogBackground,
      datePickerBackground: datePickerBackground ?? this.datePickerBackground,
      timePickerBackground: timePickerBackground ?? this.timePickerBackground,
      timePickerDialBackground:
          timePickerDialBackground ?? this.timePickerDialBackground,
      star: star ?? this.star,
    );
  }

  @override
  AppColors lerp(covariant AppColors? other, double t) {
    if (other == null) return this;

    return AppColors(
      backgroundTop: Color.lerp(backgroundTop, other.backgroundTop, t)!,
      backgroundMid: Color.lerp(backgroundMid, other.backgroundMid, t)!,
      backgroundBottom: Color.lerp(
        backgroundBottom,
        other.backgroundBottom,
        t,
      )!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      surfaceTint: Color.lerp(surfaceTint, other.surfaceTint, t)!,
      borderTint: Color.lerp(borderTint, other.borderTint, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentBright: Color.lerp(accentBright, other.accentBright, t)!,
      primaryAction: Color.lerp(primaryAction, other.primaryAction, t)!,
      selection: Color.lerp(selection, other.selection, t)!,
      selectionBorder: Color.lerp(selectionBorder, other.selectionBorder, t)!,
      selectionStrong: Color.lerp(selectionStrong, other.selectionStrong, t)!,
      selectionBright: Color.lerp(selectionBright, other.selectionBright, t)!,
      selectionDeep: Color.lerp(selectionDeep, other.selectionDeep, t)!,
      info: Color.lerp(info, other.info, t)!,
      success: Color.lerp(success, other.success, t)!,
      onSuccess: Color.lerp(onSuccess, other.onSuccess, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      shadow: Color.lerp(shadow, other.shadow, t)!,
      dialogBackground: Color.lerp(
        dialogBackground,
        other.dialogBackground,
        t,
      )!,
      datePickerBackground: Color.lerp(
        datePickerBackground,
        other.datePickerBackground,
        t,
      )!,
      timePickerBackground: Color.lerp(
        timePickerBackground,
        other.timePickerBackground,
        t,
      )!,
      timePickerDialBackground: Color.lerp(
        timePickerDialBackground,
        other.timePickerDialBackground,
        t,
      )!,
      star: Color.lerp(star, other.star, t)!,
    );
  }
}

extension AppColorsContext on BuildContext {
  AppColors get appColors => Theme.of(this).extension<AppColors>()!;
}

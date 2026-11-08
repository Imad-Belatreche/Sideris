import 'package:material_ui/material_ui.dart';
import 'package:sideris/l10n/app_font.dart';
import 'package:sideris/themes/app_colors.dart';

export 'package:sideris/themes/app_colors.dart';

abstract class AppTheme {
  AppTheme({required this.font});

  final AppFont font;

  AppColors get colors;
  ThemeData get data;

  Widget buildBackground(Widget child);

  @protected
  TextTheme buildTextTheme() {
    return TextTheme(
      /// Used in big titles like "Good morning", "Settings", "Create Notification"
      headlineLarge: font(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        letterSpacing: 0.3,
      ),

      ///Used in section titles like "Theme", "Language", "Default Notification Template"
      headlineMedium: font(
        fontSize: 18,
        color: colors.textFaint,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),

      /// Used for calendar weekday labels and compact section labels.
      headlineSmall: font(
        fontSize: 15,
        color: colors.textSecondary,
        fontWeight: FontWeight.w500,
        letterSpacing: 1,
      ),

      /// Used in normal titles like Date in calendar view or Date in list view
      titleLarge: font(fontSize: 22, fontWeight: FontWeight.w700),

      // Used in smaller titles like "Create Notification" button in creation page, notification title in list view
      titleMedium: font(fontSize: 18, fontWeight: FontWeight.w600),

      /// Used in titles of `NotificationRadioCard`
      titleSmall: font(
        fontSize: 15,
        fontWeight: FontWeight.w600,
        color: colors.textPrimary,
      ),

      /// Used in normal texts
      labelLarge: font(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: colors.textPrimary,
      ),

      /// Used in `DndSwitch` subtitle and similar
      labelMedium: font(
        fontSize: 11,
        fontWeight: FontWeight.w400,
        color: colors.textTertiary,
      ),

      /// Used for compact status badges.
      labelSmall: font(
        fontSize: 9,
        fontWeight: FontWeight.w700,
        color: colors.textMuted,
        letterSpacing: 0.7,
      ),

      /// Used in `NotificationOutlinedButton` text and similar
      bodyLarge: font(
        fontSize: 13,
        fontWeight: FontWeight.w600,
        color: colors.textSubtle,
      ),

      /// Used in normal texts like notification content in `NotificationListing`
      bodyMedium: font(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: colors.textPrimary,
      ),

      /// Used in faded texts like secondary details in `NotificationListing`
      bodySmall: font(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: colors.textDisabled,
      ),
    );
  }
}

class AppThemeScope extends InheritedWidget {
  const AppThemeScope({super.key, required this.theme, required super.child});

  final AppTheme theme;

  static AppTheme of(BuildContext context) {
    final scope = context.dependOnInheritedWidgetOfExactType<AppThemeScope>();
    assert(scope != null, 'No AppThemeScope found above this widget.');
    return scope!.theme;
  }

  @override
  bool updateShouldNotify(AppThemeScope oldWidget) => oldWidget.theme != theme;
}

extension AppThemeContext on BuildContext {
  AppTheme get appTheme => AppThemeScope.of(this);
}

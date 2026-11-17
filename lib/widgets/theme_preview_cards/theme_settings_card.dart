import 'package:material_ui/material_ui.dart';
import 'package:sideris/themes/app_theme.dart';

class ThemeSettingsCard extends StatelessWidget {
  final AppTheme theme;
  const ThemeSettingsCard({super.key, required this.theme});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 5,
      children: [
        Container(
          width: 90,
          height: 90,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              tileMode: TileMode.clamp,
              colors: [
                theme.colors.backgroundBottom,
                theme.colors.backgroundMid,
                theme.colors.backgroundTop,
              ],
            ),
            border: Border.all(color: context.appColors.borderStrong, width: 1),
            borderRadius: BorderRadius.circular(15),
          ),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              theme.icon,
              color: theme.colors.accent,
              size: theme.data.textTheme.headlineLarge!.fontSize,
            ),
          ),
        ),

        Text(theme.name, style: theme.data.textTheme.titleSmall),
      ],
    );
  }
}

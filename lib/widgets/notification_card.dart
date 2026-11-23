import 'package:material_ui/material_ui.dart';
import 'package:sideris/themes/app_theme.dart';

class NotificationCard extends StatelessWidget {
  const NotificationCard({
    super.key,
    required this.child,
    this.isSelected = false,
  });
  final bool isSelected;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final colors = context.appColors;
    return Card(
      color: isSelected
          ? Color.alphaBlend(
              colors.selection.withValues(alpha: 0.18),
              colors.cardSurface,
            )
          : colors.cardSurface,
      surfaceTintColor: Colors.transparent,
      shadowColor: colors.shadow,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: isSelected ? colors.selection : colors.borderSubtle,
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(12.0), child: child),
    );
  }
}

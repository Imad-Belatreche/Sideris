import 'package:flutter_animate/flutter_animate.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/themes/app_theme.dart';
import 'package:sideris/widgets/notification_card.dart';

class NotificationRadioCard<T> extends StatelessWidget {
  const NotificationRadioCard({
    super.key,
    required this.selectedType,
    required this.label,
    required this.isSelected,
    this.icon,
    this.child,
    this.onTap,
  });

  final T selectedType;
  final String label;
  final IconData? icon;
  final Widget? child;
  final bool isSelected;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: NotificationCard(
        isSelected: isSelected,
        child: Column(
          children: [
            Row(
              children: [
                Radio<T>(
                  side: BorderSide(
                    color: isSelected
                        ? context.appColors.selectionStrong
                        : context.appColors.textMuted,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                  value: selectedType,
                  visualDensity: VisualDensity.compact,
                ),
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: isSelected
                        ? context.appColors.selectionStrong
                        : context.appColors.textMuted,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: isSelected ? context.appColors.textPrimary : context.appColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500
                  ),
                ),
              ],
            ),

            AnimatedSwitcher(
              duration: 250.ms,
              reverseDuration: 250.ms,
              layoutBuilder: (currentChild, previousChildren) {
                return Stack(
                  alignment: Alignment.topCenter,
                  children: [...previousChildren, ?currentChild],
                );
              },
              transitionBuilder: (child, animation) {
                return SizeTransition(
                  sizeFactor: animation,
                  axis: Axis.vertical,
                  child: FadeTransition(opacity: animation, child: child),
                );
              },
              child: isSelected && child != null
                  ? KeyedSubtree(key: ValueKey(isSelected), child: child!)
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    );
  }
}

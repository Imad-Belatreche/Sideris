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
    return Card(
      color: isSelected
          ? context.appColors.selectionBackground
          : context.appColors.surface,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(
          color: isSelected
              ? context.appColors.selection
              : context.appColors.borderSubtle,
        ),
      ),
      child: Padding(padding: const EdgeInsets.all(12.0), child: child),
    );
  }
}

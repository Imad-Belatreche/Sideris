import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';
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
                    color: isSelected ? Colors.blue.shade700 : Colors.white54,
                    width: isSelected ? 2.0 : 1.0,
                  ),
                  value: selectedType,
                  visualDensity: VisualDensity.compact,
                ),
                if (icon != null) ...[
                  Icon(
                    icon,
                    color: isSelected ? Colors.blue.shade700 : Colors.white54,
                    size: 20,
                  ),
                  SizedBox(width: 8),
                ],
                Text(
                  label,
                  style: GoogleFonts.outfit(
                    fontSize: 15,
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    color: isSelected ? Colors.white : Colors.white70,
                  ),
                ),
              ],
            ),
            if (child != null && isSelected) child!,
          ],
        ),
      ),
    );
  }
}

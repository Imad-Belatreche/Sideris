import 'package:material_ui/material_ui.dart';

class NotificationOutlinedButton extends StatelessWidget {
  const NotificationOutlinedButton({
    super.key,
    required this.label,
    this.icon = const Icon(
      Icons.calendar_today,
      color: Colors.indigoAccent,
      size: 20,
    ),
    this.onPressed,
    this.isSelected,
    this.isExpanded = false,
  });

  final String label;
  final Icon icon;
  final bool? isSelected;
  final VoidCallback? onPressed;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final selected = isSelected ?? false;

    // Base dark/transparent color overlayed with blue when selected
    final backgroundColor = selected
        ? Colors.blue.withValues(alpha: 0.3)
        : Colors.white.withValues(alpha: 0.1);

    final borderColor = selected
        ? Colors.blueAccent
        : Colors.white.withValues(alpha: 0.1);

    final textColor = selected
        ? Colors.white
        : Colors.white.withValues(alpha: 0.6);

    return OutlinedButton(
      onPressed: onPressed,

      style: OutlinedButton.styleFrom(
        minimumSize: isExpanded ? const Size(double.infinity, 48) : null,
        alignment: isExpanded ? Alignment.centerLeft : Alignment.center,
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: selected ? 1.5 : 1.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
      child: Row(
        spacing: 8,
        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: isExpanded
            ? MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          if (isExpanded) icon,

          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: selected ? FontWeight.w600 : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}

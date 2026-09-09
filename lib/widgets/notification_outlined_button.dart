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
    this.isCurrentlySelected,
    this.isSelected,
    this.padding,
    this.minimumSize,
    this.isExpanded = false,
    this.centerText = false,
    this.isRounded = false,
  });

  final String label;
  final Icon? icon;
  final bool? isSelected;
  final bool? isCurrentlySelected;
  final bool centerText;
  final bool isRounded;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final VoidCallback? onPressed;
  final bool isExpanded;

  @override
  Widget build(BuildContext context) {
    final selected = isSelected ?? false;
    final currenlySelected = isCurrentlySelected ?? false;

    // Base dark/transparent color overlayed with blue when selected
    final backgroundColor = selected
        ? Colors.blue.withValues(alpha: 0.3)
        : Colors.white.withValues(alpha: 0.1);

    final borderColor = currenlySelected
        ? Colors.blueAccent.shade700
        : selected
        ? Colors.blueAccent
        : Colors.white.withValues(alpha: 0.1);

    final textColor = selected || currenlySelected
        ? Colors.white
        : Colors.white.withValues(alpha: 0.6);

    return OutlinedButton(
      onPressed: onPressed,

      style: OutlinedButton.styleFrom(
        minimumSize: isExpanded
            ? const Size(double.infinity, 48)
            : (minimumSize),
        padding: padding,
        alignment: isExpanded ? Alignment.centerLeft : Alignment.center,
        backgroundColor: backgroundColor,
        side: BorderSide(color: borderColor, width: selected ? 1.5 : 1.0),
        shape: isRounded
            ? CircleBorder()
            : RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
      ),
      child: Row(
        spacing: 8,

        mainAxisSize: isExpanded ? MainAxisSize.max : MainAxisSize.min,
        mainAxisAlignment: isExpanded
            ? centerText
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start
            : MainAxisAlignment.center,
        children: [
          if (isExpanded && icon != null) icon!,

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

import 'package:material_ui/material_ui.dart';
import 'package:sideris/themes/app_theme.dart';

class NotificationOutlinedButton extends StatelessWidget {
  const NotificationOutlinedButton({
    super.key,
    required this.label,
    this.icon,
    this.onPressed,
    this.isCurrentlySelected,
    this.isSelected,
    this.padding,
    this.minimumSize,
    this.isExpanded = false,
    this.centerText = false,
    this.isRounded = false,
    this.tailingWidget,
    this.labelStyle,
    this.labelWidget,
    this.leadingWidget,
  });

  final String label;
  final Widget? labelWidget;
  final Icon? icon;
  final bool? isSelected;
  final bool? isCurrentlySelected;
  final bool centerText;
  final bool isRounded;
  final EdgeInsetsGeometry? padding;
  final Size? minimumSize;
  final VoidCallback? onPressed;
  final bool isExpanded;
  final Widget? tailingWidget;
  final Widget? leadingWidget;
  final TextStyle? labelStyle;

  @override
  Widget build(BuildContext context) {
    final selected = isSelected ?? false;
    final currenlySelected = isCurrentlySelected ?? false;

    // Base dark/transparent color overlayed with blue when selected
    final backgroundColor = selected
        ? context.appColors.selectionOverlay
        : context.appColors.surfaceOverlay;

    final borderColor = currenlySelected
        ? context.appColors.selectionStrong
        : selected
        ? context.appColors.selectionBorder
        : context.appColors.borderSubtle;

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
          ?leadingWidget,
          ?icon,
          if (labelWidget == null)
            Text(
              label,
              style:
                  labelStyle ??
                  (selected
                      ? Theme.of(context).textTheme.labelLarge
                      : Theme.of(context).textTheme.bodyLarge!),
            )
          else
            Flexible(child: labelWidget!),

          if (tailingWidget != null) ...[Spacer(), tailingWidget!],
        ],
      ),
    );
  }
}

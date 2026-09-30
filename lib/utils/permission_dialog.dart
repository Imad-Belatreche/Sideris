import 'package:material_ui/material_ui.dart';
import 'package:sideris/l10n/l10n.dart';

//TODO: May change place later
Future<void> buildPermissionDialog(
  BuildContext context,
  String title,
  String content,
  String actionText,
  VoidCallback onPressed,
) {
  return showDialog<void>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(context.l10n.actionCancel),
        ),
        TextButton(onPressed: onPressed, child: Text(actionText)),
      ],
    ),
  );
}

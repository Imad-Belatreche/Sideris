import 'package:material_ui/material_ui.dart';
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
          child: const Text('Cancel'),
        ),
        TextButton(onPressed: onPressed, child: Text(actionText)),
      ],
    ),
  );
}

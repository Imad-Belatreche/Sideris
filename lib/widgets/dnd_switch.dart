import 'package:material_ui/material_ui.dart';

class DndSwitch extends StatelessWidget {
  const DndSwitch({
    super.key,
    required this.value,
    required this.onChanged,
    required this.isSelected,
  });

  final bool value;
  final bool? isSelected;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final selected = isSelected ?? false;

    final backgroundColor = selected
        ? Colors.blue.withValues(alpha: 0.3)
        : Colors.white.withValues(alpha: 0.1);

    final borderColor = selected
        ? Colors.blueAccent
        : Colors.white.withValues(alpha: 0.1);

    return ListTile(
      tileColor: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: borderColor, width: 1.0),
      ),
      dense: true,

      leading: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(
          Icons.do_not_disturb_on_rounded,
          color: Theme.of(context).colorScheme.primary,
        ),
      ),
      title: Text(
        'Override Do Not Disturb',
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 15,
          color: Colors.white,
        ),
      ),
      subtitle: Text(
        'Bypass device DND mode',
        style: TextStyle(color: Colors.white.withValues(alpha: 0.6)),
      ),
      trailing: Switch(value: value, onChanged: onChanged),
    );
  }
}

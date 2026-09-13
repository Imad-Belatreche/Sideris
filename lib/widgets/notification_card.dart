import 'package:material_ui/material_ui.dart';

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
      color: isSelected ? Colors.blue.withValues(alpha: 0.1) : Colors.white10,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
        side: BorderSide(color: isSelected ? Colors.blue : Colors.white10),
      ),
      child: Padding(padding: const EdgeInsets.all(12.0), child: child),
    );
  }
}

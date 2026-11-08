import 'package:material_ui/material_ui.dart';
import 'package:sideris/themes/app_theme.dart';

class CreateUpdateElevatedButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String label;
  final IconData icon;
  const CreateUpdateElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: context.appColors.primaryAction,
        padding: EdgeInsets.all(15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(20),
          side: BorderSide(color: context.appColors.borderSubtle),
        ),

        shadowColor: context.appColors.shadow,
        elevation: 10,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        spacing: 10,
        children: [
          Icon(icon, size: 20, color: context.appColors.textPrimary),
          Text(label, style: Theme.of(context).textTheme.titleMedium),
        ],
      ),
    );
  }
}

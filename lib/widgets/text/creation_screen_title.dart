import 'package:sideris/l10n/app_font.dart';
import 'package:material_ui/material_ui.dart';

class CreationScreenTitle extends StatelessWidget {
  const CreationScreenTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: appFontOf(context)(
        fontSize: 18,
        color: Colors.white30,
        fontWeight: FontWeight.w500,
        letterSpacing: 0.4,
      ),
    );
  }
}

import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class CreationScreenTitle extends StatelessWidget {
  const CreationScreenTitle({super.key, required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      style: GoogleFonts.outfit(
        fontSize: 18,
        color: Colors.white30,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

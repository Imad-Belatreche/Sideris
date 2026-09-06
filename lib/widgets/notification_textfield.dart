import 'package:google_fonts/google_fonts.dart';
import 'package:material_ui/material_ui.dart';

class NotificationTextfield extends StatelessWidget {
  const NotificationTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.maxLines,
  });
  final TextEditingController controller;
  final String hintText;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        color: Colors.white.withValues(alpha: 0.1),
        width: 2.0,
      ),
    );

    return TextField(
      controller: controller,
      maxLines: maxLines,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: GoogleFonts.outfit(
          color: Colors.white.withValues(alpha: 0.3),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
      ),
    );
  }
}

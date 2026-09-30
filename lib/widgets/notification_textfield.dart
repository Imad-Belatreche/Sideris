import 'package:flutter/services.dart';
import 'package:sideris/l10n/app_font.dart';
import 'package:material_ui/material_ui.dart';

class NotificationTextfield extends StatelessWidget {
  const NotificationTextfield({
    super.key,
    required this.controller,
    required this.hintText,
    required this.maxLines,
    this.minLines,
    this.keyboardType = TextInputType.text,
    this.isExpanded = true,
    this.isDense = false,
    this.labelText,
  });

  final TextEditingController controller;
  final String hintText;
  final String? labelText;
  final TextInputType keyboardType;
  final int maxLines;
  final int? minLines;
  final bool isExpanded;
  final bool isDense;

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.0),
      borderSide: BorderSide(
        color: Colors.white.withValues(alpha: 0.1),
        width: 2.0,
      ),
    );

    final textField = TextField(
      controller: controller,
      maxLines: maxLines,
      minLines: minLines,
      keyboardType: keyboardType,
      inputFormatters: keyboardType == TextInputType.number
          ? [
              FilteringTextInputFormatter.deny(RegExp(r'^0*')),
              FilteringTextInputFormatter.digitsOnly,
            ]
          : null,

      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: appFontOf(context)(
          color: Colors.white70,
          fontSize: 18,
          fontWeight: FontWeight.w600,
        ),
        hintText: hintText,
        hintStyle: appFontOf(context)(
          color: Colors.white.withValues(alpha: 0.3),
          fontSize: 16,
          fontWeight: FontWeight.w400,
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.05),
        border: border,
        enabledBorder: border,
        focusedBorder: border,
        isDense: isDense,
      ),
    );

    return isExpanded
        ? SizedBox(width: double.infinity, child: textField)
        : IntrinsicWidth(
            child: Container(
              constraints: BoxConstraints(maxWidth: 150),
              child: textField,
            ),
          );
  }
}

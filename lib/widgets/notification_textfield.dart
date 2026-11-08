import 'package:flutter/services.dart';
import 'package:material_ui/material_ui.dart';
import 'package:sideris/themes/app_theme.dart';

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
      borderSide: BorderSide(color: context.appColors.borderSubtle, width: 2.0),
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
        labelStyle: Theme.of(context).textTheme.titleMedium,
        hintText: hintText,
        hintStyle: Theme.of(context).textTheme.bodyMedium,
        filled: true,
        fillColor: context.appColors.fieldFill,
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

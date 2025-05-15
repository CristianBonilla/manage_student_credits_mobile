import 'package:flutter/material.dart';

class InputFormDecoration extends StatelessWidget {
  final String? hinText;
  final String? labelText;
  final Color labelColor;
  final Color borderColor;
  final IconData? icon;
  final TextInputType? inputType;
  final FormFieldValidator<String>? validator;

  const InputFormDecoration({
    super.key,
    this.hinText,
    this.labelText,
    this.labelColor = Colors.blueGrey,
    this.borderColor = Colors.deepPurple,
    this.icon,
    this.inputType,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLines: inputType == TextInputType.multiline ? 3 : 1,
      autocorrect: false,
      keyboardType: inputType,
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: borderColor, width: 3),
        ),
        hintText: hinText,
        hintStyle: TextStyle(fontSize: 20),
        labelText: labelText,
        labelStyle: TextStyle(color: labelColor, fontSize: 18),
        prefixIcon:
            icon != null ? Icon(icon, color: borderColor, size: 30) : null,
      ),
      validator: validator,
    );
  }
}

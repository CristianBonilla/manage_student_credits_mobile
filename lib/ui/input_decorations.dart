import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration inputFormDecoration({
    String? hinText,
    String? labelText,
    Color borderColor = Colors.deepPurple,
    Color labelColor = Colors.blueGrey,
    IconData? icon,
  }) {
    return InputDecoration(
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
    );
  }
}

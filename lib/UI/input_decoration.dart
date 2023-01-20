import 'package:flutter/material.dart';

class InputDecorations {
  static InputDecoration authInputDecoration({
    required String hintText,
    required String labelText,
    IconData? prefixIcon,
    Color? prefixIconColor,
    Color? labelTextColor,
  }) {
    return InputDecoration(
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Colors.deepPurple,
          ),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.deepPurple, width: 2),
        ),
        hintText: hintText,
        labelText: labelText,
        labelStyle: TextStyle(color: labelTextColor),
        prefixIcon: Icon(
          prefixIcon,
          color: prefixIconColor,
        ));
  }
}

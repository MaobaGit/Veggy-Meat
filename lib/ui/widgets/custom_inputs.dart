import 'package:flutter/material.dart';
import 'package:veggy/theme/colors.dart';

class CustomInputs {
  static InputDecoration loginInputDecoration({
    required String hint,
    String? errorText,
    required String label,
    required IconData icon,
  }) {
    return InputDecoration(
      border: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      enabledBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorsApp.colorPaletteGreen.withOpacity(0.3))),
      focusedBorder:
          OutlineInputBorder(borderSide: BorderSide(color: Colors.green)),
      hintText: hint,
      labelText: label,
      errorText: errorText,
      prefixIcon: Icon(icon,
          color: errorText == null
              ? ColorsApp.colorPaletteGreen
              : Colors.red[400]),
      labelStyle: TextStyle(color: Colors.grey),
      hintStyle: TextStyle(color: Colors.grey),
    );
  }

  static InputDecoration searchInputDecoration(
      {required String hint, required IconData icon}) {
    return InputDecoration(
        border: InputBorder.none,
        enabledBorder: InputBorder.none,
        hintText: hint,
        prefixIcon: Icon(icon, color: Colors.grey),
        labelStyle: TextStyle(color: Colors.grey),
        hintStyle: TextStyle(color: Colors.grey));
  }
}

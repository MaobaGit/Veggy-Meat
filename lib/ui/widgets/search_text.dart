import 'package:flutter/material.dart';

class SearchText extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      decoration: buildBoxDecoration(),
      child: TextField(
        decoration:
            searchInputDecoration(hint: 'Buscar', icon: Icons.search_outlined),
      ),
    );
  }

  BoxDecoration buildBoxDecoration() => BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.grey.withOpacity(0.1));

  InputDecoration searchInputDecoration(
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

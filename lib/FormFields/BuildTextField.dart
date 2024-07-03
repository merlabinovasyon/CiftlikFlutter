import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;

  const BuildTextField({super.key, required this.label, required this.hint, this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black54,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black), // Label rengi
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen $label girin';
        }
        return null;
      },
    );
  }
}

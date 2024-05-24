import 'package:flutter/material.dart';

class BuildTextField extends StatelessWidget {
  final String label;
  final String hint;
  const BuildTextField({super.key, required this.label, required this.hint});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Lütfen $label girin';
        }
        return null;
      },
    );  }
}

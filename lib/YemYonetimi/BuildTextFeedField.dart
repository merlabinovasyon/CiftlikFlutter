import 'package:flutter/material.dart';

class BuildTextFeedField extends StatelessWidget {
  final String label;
  final String hint;
  final TextEditingController? controller;
  final String? Function(String?)? validator; // Validator parametresi eklendi

  const BuildTextFeedField({
    super.key,
    required this.label,
    required this.hint,
    this.controller,
    this.validator, // Validator parametresini kabul et
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black54,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.black), // Label rengi
        hintText: hint,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: const BorderSide(color: Colors.black), // Odaklanıldığında border rengi
        ),
      ),
      validator: validator, // Validator burada kullanılıyor
    );
  }
}

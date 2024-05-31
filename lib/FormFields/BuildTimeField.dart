import 'package:flutter/material.dart';

class BuildTimeField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(BuildContext, TextEditingController) onTap;

  const BuildTimeField({
    Key? key,
    required this.label,
    required this.controller,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.keyboard_arrow_down), // İkon ekleme
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: true,
      onTap: () => onTap(context, controller),
    );
  }
}

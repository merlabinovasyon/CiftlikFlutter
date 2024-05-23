import 'package:flutter/material.dart';
import 'package:get/get.dart';

class BuildDateField extends StatelessWidget {

  final String label;
  final TextEditingController controller;
  const BuildDateField({super.key,re, required this.label, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
        );
        if (pickedDate != null) {
          controller.text = "${pickedDate.day}/${pickedDate.month}/${pickedDate.year}";
        }
      },
    );
  }
}

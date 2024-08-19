import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'FormTimeScheduleUtils.dart';

class BuildTimeScheduleField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Rx<DateTime?> selectedDateTime;

  const BuildTimeScheduleField({
    Key? key,
    required this.label,
    required this.controller,
    required this.selectedDateTime,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FormTimeScheduleUtils utils = FormTimeScheduleUtils();

    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: const Icon(Icons.keyboard_arrow_down), // İkon ekleme
        labelText: label,
        labelStyle: TextStyle(color: Colors.black), // Label rengi
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.0),
          borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
        ),
      ),
      readOnly: true,
      onTap: () => utils.showTimeSchedulePicker(context, controller, selectedDateTime),
    );
  }
}

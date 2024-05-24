import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../buzagi_ekleme/AddBirthBuzagiController.dart';
import '../buzagi_ekleme/buzagi_utils.dart';

class BuildTimeField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final AddBirthBuzagiController controller1;
  const BuildTimeField({super.key,required this.label,required this.controller,required this.controller1});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: Icon(Icons.keyboard_arrow_down), // İkon ekleme
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      readOnly: true,
      onTap: () {
        ShowTimePicker(Get.context!,controller1);
      },
    );  }
}

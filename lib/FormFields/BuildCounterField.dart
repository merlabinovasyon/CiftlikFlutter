import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../FormUtils/FormUtils.dart';

class BuildCounterField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final String title;
  final FormUtils utils = FormUtils();
  BuildCounterField({super.key,required this.label,required this.controller, required this.title});


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
      onTap: () {
        utils.showCounterPicker(Get.context!, controller,title); // utils.dart dosyasındaki fonksiyonu kullanın
      },
    );
  }
}

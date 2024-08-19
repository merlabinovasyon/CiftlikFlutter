import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'VaccineScheduleUtils.dart';

class BuildSelectionVaccineScheduleField extends StatelessWidget {
  final String label;
  final Rxn<String> value;
  final List<String> options;
  final Function(String) onSelected;
  final VaccineScheduleUtils utils = VaccineScheduleUtils();

  BuildSelectionVaccineScheduleField({
    required this.label,
    required this.value,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
      onTap: () {
        utils.showSelectionVaccineSheet(context, label, options, onSelected);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
          ),
          suffixIcon: const Icon(Icons.keyboard_arrow_down),
        ),
        child: value.value == null ? const Text('Seç') : Text(value.value!),
      ),
    ));
  }
}

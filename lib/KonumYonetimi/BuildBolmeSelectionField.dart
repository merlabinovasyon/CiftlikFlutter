import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../FormUtils/FormUtils.dart';

class BuildBolmeSelectionField extends StatelessWidget {
  final String label;
  final Rxn<int> value;
  final List<Map<String, dynamic>> options;
  final Function(int) onSelected;
  final FormUtils utils = FormUtils();

  BuildBolmeSelectionField({
    super.key,
    required this.label,
    required this.value,
    required this.options,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
      onTap: () {
        List<String> optionNames = options.map((option) => option['name'] as String).toList();
        utils.ShowSelectionSheet(context, label, optionNames, (selectedName) {
          int selectedId = options.firstWhere((option) => option['name'] == selectedName)['id'];
          onSelected(selectedId);
        });
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: const Icon(Icons.keyboard_arrow_down),
        ),
        child: value.value == null ? const Text('Seç') : Text(options.firstWhere((option) => option['id'] == value.value)['name']),
      ),
    ));
  }
}

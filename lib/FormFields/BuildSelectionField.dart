import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../buzagi_ekleme/buzagi_utils.dart';

class BuildSelectionField extends StatelessWidget {
     final String label;
     final Rxn<String> value;
     final List<String> options;
     final Function(String) onSelected;

  const BuildSelectionField({super.key,required this.label,required this.value,required this.options,required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return Obx(() => InkWell(
      onTap: () {
        ShowSelectionSheet(context, label, options, onSelected);
      },
      child: InputDecorator(
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          suffixIcon: Icon(Icons.keyboard_arrow_down),
        ),
        child: value.value == null ? Text('Seç') : Text(value.value!),
      ),
    ));
  }
}


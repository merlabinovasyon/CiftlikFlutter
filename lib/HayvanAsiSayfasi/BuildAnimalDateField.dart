import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BuildAnimalDateField extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final Function(String) onDateSelected;

  const BuildAnimalDateField({super.key, required this.label, required this.controller, required this.onDateSelected});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(color: Colors.black), // Label rengi
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
        ),
      ),
      readOnly: true,
      onTap: () async {
        DateTime? pickedDate = await showDatePicker(
          context: Get.context!,
          initialDate: DateTime.now(),
          firstDate: DateTime(2000),
          lastDate: DateTime(2101),
          locale: const Locale('tr', 'TR'),
          builder: (context, child) {
            return Theme(
              data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Colors.cyan.withOpacity(0.5),
                  onPrimary: Colors.white,
                  surface: Colors.black,
                  onSurface: Colors.white,
                ),
                dialogBackgroundColor: Colors.blueGrey[800],
              ),
              child: child!,
            );
          },
        );
        if (pickedDate != null) {
          String formattedDate = DateFormat('d MMMM y', 'tr').format(pickedDate);
          controller.text = formattedDate;
          onDateSelected(formattedDate);
        }
      },
    );
  }
}

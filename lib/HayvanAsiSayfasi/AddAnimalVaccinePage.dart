import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/FormButton.dart';
import 'AddAnimalVaccineController.dart';
import 'BuildAnimalDateField.dart';
import 'BuildAnimalSelectionField.dart';

class AddAnimalVaccinePage extends StatelessWidget {
  final AddAnimalVaccineController controller = Get.put(AddAnimalVaccineController());

  AddAnimalVaccinePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        controller.resetForm();
        return true; // Pop işleminin devam etmesini sağla
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Aşılama Ekle', style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        controller.resetForm();
                        Get.back();
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    labelText: 'Notlar',
                    labelStyle: TextStyle(color: Colors.black),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.grey, width: 1.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  onChanged: (value) {
                    controller.notes.value = value;
                  },
                ),
                const SizedBox(height: 16),
                BuildAnimalDateField(
                  label: 'Tarih',
                  controller: dateController,
                  onDateSelected: (selectedDate) {
                    controller.date.value = selectedDate;
                  },
                ),
                const SizedBox(height: 16),
                BuildAnimalSelectionField(
                  label: 'Aşı Tipi *',
                  value: controller.vaccineType,
                  options: ['Aşı Tipi 1', 'Aşı Tipi 2'],
                  onSelected: (value) {
                    controller.vaccineType.value = value;
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8),
                  child: FormButton(
                    title: 'Kaydet',
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addVaccine();
                        controller.resetForm();
                        Get.back();
                        Get.snackbar('Başarılı', 'Yapılan Aşı Kaydedildi');
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

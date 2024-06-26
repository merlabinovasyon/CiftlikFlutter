import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/FormButton.dart';
import '../HayvanAsiSayfasi/BuildAnimalDateField.dart';
import '../HayvanAsiSayfasi/BuildAnimalSelectionField.dart';
import 'AddAnimalLocationController.dart';


class AddAnimalLocationPage extends StatelessWidget {
  final AddAnimalLocationController controller = Get.put(AddAnimalLocationController());

  AddAnimalLocationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController dateController = TextEditingController();

    return WillPopScope(
      onWillPop: () async {
        controller.resetForm();
        return true;
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
                    Text('Ahır / Bölme Kaydet', style: TextStyle(fontSize: 18)),
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
                BuildAnimalDateField(
                  label: 'Tarih',
                  controller: dateController,
                  onDateSelected: (selectedDate) {
                    controller.date.value = selectedDate;
                  },
                ),
                const SizedBox(height: 16),
                BuildAnimalSelectionField(
                  label: 'Lokasyon *',
                  value: controller.location,
                  options: ['Ahır 1/Bölme 1', 'Ahır 1/Bölme 2'],
                  onSelected: (value) {
                    controller.location.value = value;
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8),
                  child: FormButton(
                    title: 'Kaydet',
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addLocation();
                        controller.resetForm();
                        Get.back();
                        Get.snackbar('Başarılı', 'Lokasyon Kaydedildi');
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

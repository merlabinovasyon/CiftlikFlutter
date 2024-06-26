import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalGroupController.dart';
import '../FormFields/FormButton.dart';
import '../HayvanAsiSayfasi/BuildAnimalSelectionField.dart';

class AddAnimalGroupPage extends StatelessWidget {
  final AnimalGroupController controller = Get.find<AnimalGroupController>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.resetForm();
        return true;
      },
      child: Dialog(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Grup Seçimi', style: TextStyle(fontSize: 18)),
                    IconButton(
                      icon: Icon(Icons.close),
                      onPressed: () {
                        controller.resetForm();
                        Get.back();
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                BuildAnimalSelectionField(
                  label: 'Grup Seçimi *',
                  value: controller.selectedGroup,
                  options: controller.availableGroups, // Güncellenen grup listesini kullan
                  onSelected: (value) => controller.selectedGroup.value = value,
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: FormButton(
                    title: 'Kaydet',
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.saveGroup();
                        controller.resetForm();
                        Get.back();
                        Get.snackbar('Başarılı', 'Grup Kaydedildi');
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

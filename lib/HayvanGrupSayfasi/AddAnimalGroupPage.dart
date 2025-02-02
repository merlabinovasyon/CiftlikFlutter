import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddAnimalGroupController.dart';
import '../FormFields/FormButton.dart';
import '../HayvanAsiSayfasi/BuildAnimalSelectionField.dart';

class AddAnimalGroupPage extends StatelessWidget {
  final AddAnimalGroupController controller = Get.put(AddAnimalGroupController());
  final String tagNo;

  AddAnimalGroupPage({Key? key, required this.tagNo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        controller.resetForm();
        return true; // Pop işleminin devam etmesini sağla
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
                  options: ['Grup 1', 'Grup 2', 'Grup 3'],
                  onSelected: (value) => controller.selectedGroup.value = value,
                ),
                SizedBox(height: 16),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0, left: 8),
                  child: FormButton(
                    title: 'Kaydet',
                    onPressed: () async {
                      if (controller.formKey.currentState!.validate()) {
                        await controller.addGroup(tagNo); // addGroup fonksiyonunu async olarak çağırıyoruz
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

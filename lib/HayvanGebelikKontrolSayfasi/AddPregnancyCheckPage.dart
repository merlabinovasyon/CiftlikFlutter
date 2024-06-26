import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/FormButton.dart';
import '../HayvanAsiSayfasi/BuildAnimalDateField.dart';
import '../HayvanAsiSayfasi/BuildAnimalSelectionField.dart';
import 'AddPregnancyCheckController.dart';


class AddPregnancyCheckPage extends StatelessWidget {
  final AddPregnancyCheckController controller = Get.put(AddPregnancyCheckController());

  AddPregnancyCheckPage({Key? key}) : super(key: key);

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
                    Text('Gebelik Kontrolü', style: TextStyle(fontSize: 18)),
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
                  label: 'Kontrol Sonucu *',
                  value: controller.kontrolSonucu,
                  options: ['Gebe', 'Gebe Değil'],
                  onSelected: (value) {
                    controller.kontrolSonucu.value = value;
                  },
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(right: 8.0,left: 8),
                  child: FormButton(
                    title: 'Kaydet',
                    onPressed: () {
                      if (controller.formKey.currentState!.validate()) {
                        controller.addKontrol();
                        controller.resetForm();
                        Get.back();
                        Get.snackbar('Başarılı', 'Gebelik Kontrolü Kaydedildi');
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

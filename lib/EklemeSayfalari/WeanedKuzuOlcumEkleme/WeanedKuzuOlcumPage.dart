import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormUtils/FormUtils.dart';
import '../../FormFields/BuildSelectionField.dart';
import '../../FormFields/FormButton.dart';
import '../../FormFields/WeightField.dart';
import '../../FormFields/BuildDateField.dart';
import '../../FormFields/BuildTimeField.dart';
import 'WeanedKuzuOlcumController.dart';

class WeanedKuzuOlcumPage extends StatelessWidget {
  final WeanedKuzuOlcumController controller = Get.put(WeanedKuzuOlcumController());
  final FormUtils utils = FormUtils();

  WeanedKuzuOlcumPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            controller.resetForm();
            Get.back();
          },
        ),
        title: Center(
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: Container(
              height: 40,
              width: 130,
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('resimler/logo_v2.png'),
                  fit: BoxFit.fill,
                ),
              ),
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              const SizedBox(height: 10),
              const Text(
                'Sütten kesilmiş ölçümü yapılan kuzunuzu seçiniz.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              WeightField(),
              const SizedBox(height: 25),
              BuildSelectionField(
                label: 'Kuzunuz *',
                value: controller.selectedType,
                options: controller.types,
                onSelected: (value) {
                  controller.selectedType.value = value;
                },
              ),
              const SizedBox(height: 16),
              BuildDateField(
                label: 'Tarih',
                controller: controller.dateController,
              ),
              const SizedBox(height: 16),
              BuildTimeField(
                label: 'Saat',
                controller: controller.timeController,
                onTap: utils.showTimePicker,
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: controller.saveWeanedKuzuData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

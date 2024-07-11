import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/InekSutOlcumEkleme/InekSutOlcumController.dart';
import 'package:merlabciftlikyonetim/FormUtils/FormUtils.dart';
import '../../FormFields/BuildSelectionField.dart';
import '../../FormFields/FormButton.dart';
import '../../FormFields/WeightField.dart';
import '../../FormFields/BuildDateField.dart';
import '../../FormFields/BuildTimeField.dart';
import '../../AnimalService/BuildSelectionAnimalField.dart';

class InekSutOlcumPage extends StatelessWidget {
  final InekSutOlcumController controller = Get.put(InekSutOlcumController());
  final FormUtils utils = FormUtils();

  InekSutOlcumPage({super.key});

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
                'Süt ölçümü yapılan ineğinizi seçiniz.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const WeightField(),
              const SizedBox(height: 25),
              BuildSelectionAnimalField(
                label: 'İneğiniz *',
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
                  onPressed: controller.saveSutOlcumInekData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

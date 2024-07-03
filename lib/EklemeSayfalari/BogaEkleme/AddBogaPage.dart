import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildSelectionField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildDateField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildTimeField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildTextField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildCounterField.dart';
import 'package:merlabciftlikyonetim/FormUtils/FormUtils.dart';
import '../../FormFields/FormButton.dart';
import '../../FormFields/WeightField.dart';
import 'AddBogaController.dart';

class AddBogaPage extends StatelessWidget {
  final AddBogaController controller = Get.put(AddBogaController());
  final FormUtils utils = FormUtils();

  AddBogaPage({super.key});

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
                'Boğanızın bilgilerini giriniz.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              WeightField(),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: BuildTextField(
                      label: 'Küpe No *',
                      hint: 'GEÇİCİ_NO_16032',
                      controller: controller.tagNoController,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0,bottom: 2,left: 10),
                    child: SizedBox(
                      width: 100, // İstediğiniz genişlik
                      height: 50, // İstediğiniz yükseklik
                      child: FormButton(
                        title: 'Tara',
                        onPressed: () {
                          // Kontrol etme işlemi burada yapılacak
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Devlet Küpe No *',
                hint: 'GEÇİCİ_NO_16032',
                controller: controller.govTagNoController,
              ),
              const SizedBox(height: 16),
              BuildSelectionField(
                label: 'Irk *',
                value: controller.selectedBoga,
                options: controller.boga,
                onSelected: (value) {
                  controller.selectedBoga.value = value;
                },
              ),
              const SizedBox(height: 16),
              BuildTextField(
                label: 'Hayvan Adı',
                hint: '',
                controller: controller.nameController,
              ),
              const SizedBox(height: 16),
              BuildCounterField(
                label: 'Boğa Tipi',
                controller: controller.countController,
                title: 'boğa',
              ),
              const SizedBox(height: 16),
              BuildDateField(
                label: 'Boğanın Kayıt Tarihi *',
                controller: controller.dobController,
              ),
              const SizedBox(height: 16),
              BuildTimeField(
                label: 'Boğanın Kayıt Zamanı',
                controller: controller.timeController,
                onTap: utils.showTimePicker,
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,right: 8,left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: controller.saveBogaData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/WeightField.dart';
import '../../FormFields/BuildCounterField.dart';
import '../../FormFields/BuildDateField.dart';
import '../../FormFields/BuildSelectionField.dart';
import '../../FormFields/BuildTextField.dart';
import '../../FormFields/BuildTimeField.dart';
import '../../FormFields/FormButton.dart';
import '../../FormFields/TwinOrTripletSection.dart';
import '../../FormUtils/FormUtils.dart';
import 'AddBirthBuzagiController.dart';

class AddBirthBuzagiPage extends StatelessWidget {
  final AddBirthBuzagiController controller = Get.put(AddBirthBuzagiController());
  final FormUtils utils = FormUtils();

  AddBirthBuzagiPage({super.key});

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
                'Yeni doğan buzağı/buzağılarınızın bilgilerini giriniz.',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 5),
              const WeightField(),
              const SizedBox(height: 25),
              BuildSelectionField(label: 'Doğuran Hayvan *', value: controller.selectedAnimal, options: controller.animals, onSelected: (value) {
                controller.selectedAnimal.value = value;
              }),
              const SizedBox(height: 16),
              BuildSelectionField(label: 'Boğanız *', value: controller.selectedKoc, options: controller.boga, onSelected: (value) {
                controller.selectedKoc.value = value;
              }),
              const SizedBox(height: 16),
              BuildDateField(label: 'Doğum Yaptığı Tarih *', controller: controller.dobController),
              const SizedBox(height: 16),
              BuildTimeField(label: 'Doğum Zamanı', controller: controller.timeController, onTap: utils.showTimePicker),
              const SizedBox(height: 24),
              const Text('1. Buzağı', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              const BuildTextField(label: 'Küpe No *', hint: 'GEÇİCİ_NO_16032'),
              const SizedBox(height: 16),
              const BuildTextField(label: 'Devlet Küpe No *', hint: 'GEÇİCİ_NO_16032'),
              const SizedBox(height: 16),
              BuildSelectionField(label: 'Irk *', value: controller.selectedBuzagi, options: controller.buzagi, onSelected: (value) {
                controller.selectedBuzagi.value = value;
              }),
              const SizedBox(height: 16),
              const BuildTextField(label: 'Hayvan Adı', hint: ''),
              const SizedBox(height: 16),
              BuildSelectionField(label: 'Cinsiyet *', value: controller.selectedGender1, options: controller.genders, onSelected: (value) {
                controller.selectedGender1.value = value;
              }),
              const SizedBox(height: 16),
              BuildCounterField(label: 'Buzağı Tipi', controller: controller.countController, title: 'buzağı',),
              const SizedBox(height: 24),
              TwinOrTripletSection(
                label: 'İkiz',
                isMultiple: controller.isTwin,
                onChanged: (value) {
                  controller.isTwin.value = value;
                  if (!value) {
                    controller.isTriplet.value = false;
                    controller.resetTwinValues();
                  }
                },
                buildFields: [
                  const SizedBox(height: 16),
                  const BuildTextField(label: 'Küpe No *', hint: ''),
                  const SizedBox(height: 16),
                  const BuildTextField(label: 'Devlet Küpe No *', hint: 'GEÇİCİ_NO_16032'),
                  const SizedBox(height: 16),
                  BuildSelectionField(label: 'Irk *', value: controller.selected1Buzagi, options: controller.buzagi1, onSelected: (value) {
                    controller.selected1Buzagi.value = value;
                  }),
                  const SizedBox(height: 16),
                  const BuildTextField(label: 'Hayvan Adı', hint: ''),
                  const SizedBox(height: 16),
                  BuildSelectionField(label: 'Cinsiyet *', value: controller.selectedGender2, options: controller.genders, onSelected: (value) {
                    controller.selectedGender2.value = value;
                  }),
                  const SizedBox(height: 16),
                  BuildCounterField(label: 'Buzağı Tipi', controller: controller.count1Controller, title: 'buzağı',),
                  const SizedBox(height: 24),
                ],
                additionalSection: TwinOrTripletSection(
                  label: 'Üçüz',
                  isMultiple: controller.isTriplet,
                  onChanged: (value) {
                    controller.isTriplet.value = value;
                    if (!value) {
                      controller.resetTripletValues();
                    }
                  },
                  buildFields: [
                    const SizedBox(height: 16),
                    const BuildTextField(label: 'Küpe No *', hint: ''),
                    const SizedBox(height: 16),
                    const BuildTextField(label: 'Devlet Küpe No *', hint: 'GEÇİCİ_NO_16032'),
                    const SizedBox(height: 16),
                    BuildSelectionField(label: 'Irk *', value: controller.selected2Buzagi, options: controller.buzagi1, onSelected: (value) {
                      controller.selected2Buzagi.value = value;
                    }),
                    const SizedBox(height: 16),
                    const BuildTextField(label: 'Hayvan Adı', hint: ''),
                    const SizedBox(height: 16),
                    BuildSelectionField(label: 'Cinsiyet *', value: controller.selectedGender3, options: controller.genders, onSelected: (value) {
                      controller.selectedGender3.value = value;
                    }),
                    const SizedBox(height: 16),
                    BuildCounterField(label: 'Buzağı Tipi', controller: controller.count2Controller, title: 'buzağı',),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0,right: 8,left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      Get.snackbar(
                        'Başarılı',
                        'Kayıt başarılı',
                      );
                      Future.delayed(const Duration(seconds: 1), () {
                        Get.offAllNamed('/bottomNavigation');
                      });
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

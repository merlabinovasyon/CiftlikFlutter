import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/WeightField.dart';
import 'package:merlabciftlikyonetim/FormUtils/FormUtils.dart';
import '../../FormFields/BuildCounterField.dart';
import '../../FormFields/BuildDateField.dart';
import '../../FormFields/BuildSelectionField.dart';
import '../../FormFields/BuildTimeField.dart';
import '../../AnimalService/BuildSelectionAnimalField.dart';
import '../../AnimalService/BuildSelectionSpeciesField.dart';
import '../../FormFields/BuildTextField.dart';
import '../../FormFields/TwinOrTripletSection.dart';
import 'AddBirthKuzuController.dart';
import '../../FormFields/FormButton.dart';

class AddBirthKuzuPage extends StatelessWidget {
  final AddBirthKuzuController controller = Get.put(AddBirthKuzuController());
  final FormUtils utils = FormUtils();

  AddBirthKuzuPage({super.key});

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
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: controller.formKey,
          child: ListView(
            children: [
              SizedBox(height: 10),
              Text(
                'Yeni doğan kuzunuzun/kuzularınızın bilgilerini giriniz.',
                style: TextStyle(fontSize: 16),
              ),
              SizedBox(height: 5),
              WeightField(),
              SizedBox(height: 25),
              BuildSelectionAnimalField(
                label: 'Koyununuz *',
                value: controller.selectedAnimal,
                options: controller.animals,
                onSelected: (value) {
                  controller.selectedAnimal.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionAnimalField(
                label: 'Koçunuz *',
                value: controller.selectedKoc,
                options: controller.koc,
                onSelected: (value) {
                  controller.selectedKoc.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildDateField(
                label: 'Doğum Yaptığı Tarih *',
                controller: controller.dobController,
              ),
              SizedBox(height: 16),
              BuildTimeField(
                label: 'Doğum Zamanı',
                controller: controller.timeController,
                onTap: utils.showTimePicker,
              ),
              SizedBox(height: 24),
              Text(
                '1. Kuzu',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 16),
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
                    padding: const EdgeInsets.only(right: 8.0, bottom: 2, left: 10),
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
              SizedBox(height: 16),
              BuildTextField(
                label: 'Devlet Küpe No *',
                hint: 'GEÇİCİ_NO_16032',
                controller: controller.govTagNoController,
              ),
              SizedBox(height: 16),
              BuildSelectionSpeciesField(
                label: 'Irk *',
                value: controller.selectedLamb,
                options: controller.species,
                onSelected: (value) {
                  var selectedSpecies = controller.species.firstWhere((element) => element['animalsubtypename'] == value);
                  controller.selectedLamb.value = value;
                  controller.selectedLambId.value = selectedSpecies['id'];
                },
              ),
              SizedBox(height: 16),
              BuildTextField(
                label: 'Hayvan Adı',
                hint: '',
                controller: controller.nameController,
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Cinsiyet *',
                value: controller.selectedGender1,
                options: controller.genders,
                onSelected: (value) {
                  controller.selectedGender1.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildCounterField(
                label: 'Kuzu Tipi',
                controller: controller.countController,
                title: 'kuzu',
              ),
              SizedBox(height: 24),
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
                  SizedBox(height: 16),
                  BuildTextField(label: 'Küpe No *', hint: ''),
                  SizedBox(height: 16),
                  BuildTextField(label: 'Devlet Küpe No *', hint: 'GEÇİCİ_NO_16032'),
                  SizedBox(height: 16),
                  BuildSelectionSpeciesField(
                    label: 'Irk *',
                    value: controller.selected1Lamb,
                    options: controller.species,
                    onSelected: (value) {
                      var selectedSpecies = controller.species.firstWhere((element) => element['animalsubtypename'] == value);
                      controller.selected1Lamb.value = value;
                      controller.selected1LambId.value = selectedSpecies['id'];
                    },
                  ),
                  SizedBox(height: 16),
                  BuildTextField(label: 'Hayvan Adı', hint: ''),
                  SizedBox(height: 16),
                  BuildSelectionField(
                    label: 'Cinsiyet *',
                    value: controller.selectedGender2,
                    options: controller.genders,
                    onSelected: (value) {
                      controller.selectedGender2.value = value;
                    },
                  ),
                  SizedBox(height: 16),
                  BuildCounterField(
                    label: 'Kuzu Tipi',
                    controller: controller.count1Controller,
                    title: 'kuzu',
                  ),
                  SizedBox(height: 24),
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
                    SizedBox(height: 16),
                    BuildTextField(label: 'Küpe No *', hint: ''),
                    SizedBox(height: 16),
                    BuildTextField(label: 'Devlet Küpe No *', hint: 'GEÇİCİ_NO_16032'),
                    SizedBox(height: 16),
                    BuildSelectionSpeciesField(
                      label: 'Irk *',
                      value: controller.selected2Lamb,
                      options: controller.species,
                      onSelected: (value) {
                        var selectedSpecies = controller.species.firstWhere((element) => element['animalsubtypename'] == value);
                        controller.selected2Lamb.value = value;
                        controller.selected2LambId.value = selectedSpecies['id'];
                      },
                    ),
                    SizedBox(height: 16),
                    BuildTextField(label: 'Hayvan Adı', hint: ''),
                    SizedBox(height: 16),
                    BuildSelectionField(
                      label: 'Cinsiyet *',
                      value: controller.selectedGender3,
                      options: controller.genders,
                      onSelected: (value) {
                        controller.selectedGender3.value = value;
                      },
                    ),
                    SizedBox(height: 16),
                    BuildCounterField(
                      label: 'Kuzu Tipi',
                      controller: controller.count2Controller,
                      title: 'kuzu',
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                child: FormButton(
                  title: 'Kaydet',
                  onPressed: controller.saveLambData,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

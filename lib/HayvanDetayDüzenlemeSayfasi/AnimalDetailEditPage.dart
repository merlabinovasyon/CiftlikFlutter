import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/AnimalService/BuildSelectionAnimalField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildCounterField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildDateField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildSelectionField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildTextField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildTimeField.dart';
import 'package:merlabciftlikyonetim/FormFields/FormButton.dart';
import '../AnimalService/BuildSelectionLocationField.dart';
import '../AnimalService/BuildSelectionSpeciesField.dart';
import '../FormUtils/FormUtils.dart';
import 'AnimalDetailEditController.dart';

class AnimalDetailEditPage extends StatelessWidget {
  final AnimalDetailEditController controller = Get.put(AnimalDetailEditController());
  final FormUtils utils = FormUtils();
  final String tableName;
  final int animalId;

  AnimalDetailEditPage({required this.tableName, required this.animalId}) {
    controller.loadAnimalDetails(tableName, animalId);
  }

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
              BuildTextField(
                label: 'Küpe No',
                controller: controller.tagNoController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildTextField(
                label: 'Ad',
                controller: controller.nameController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildDateField(
                label: 'Doğum Tarihi',
                controller: controller.dobController,
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Durum',
                value: controller.status,
                options: ['Durum1', 'Durum2'],
                onSelected: (value) {
                  controller.status.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildTextField(
                label: 'Kemer No',
                controller: controller.beltNoController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildTextField(
                label: 'Lak.no: 1 / 0 SGS',
                controller: controller.lakNoController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildTextField(
                label: 'Pedometre',
                controller: controller.pedometerController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildSelectionSpeciesField(
                label: 'Irk',
                value: controller.speciesController,
                options: controller.speciesOptions,
                onSelected: (value) {
                  var selectedSpecies = controller.speciesOptions.firstWhere((element) => element['animalsubtypename'] == value);
                  controller.speciesController.value = selectedSpecies['animalsubtypename'];
                },
              ),
              SizedBox(height: 16),
              BuildSelectionLocationField(
                label: 'Lokasyon *',
                value: controller.location,
                options: controller.locations,
                onSelected: (value) {
                  controller.location.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildTextField(
                label: 'Notlar',
                controller: controller.notesController,
                hint: '',
              ),
              SizedBox(height: 16),

              // Ana ID için doğru hayvan listesi
              BuildSelectionAnimalField(
                label: 'Ana ID',
                value: controller.motherController,
                options: controller.motherOptions, // Bu kısmı değiştirdik
                onSelected: (value) {
                  var selectedMother = controller.motherOptions.firstWhere((element) => element['tagNo'] == value);
                  controller.motherController.value = selectedMother['tagNo'].toString();
                },
              ),
              SizedBox(height: 16),
              BuildSelectionAnimalField(
                label: 'Baba ID',
                value: controller.fatherController,
                options: controller.fatherOptions, // Bu kısmı değiştirdik
                onSelected: (value) {
                  var selectedFather = controller.fatherOptions.firstWhere((element) => element['tagNo'] == value);
                  controller.fatherController.value = selectedFather['tagNo'].toString();
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Sürüde doğdu',
                value: controller.bornInHerdController,
                options: ['Evet', 'Hayır'],
                onSelected: (value) {
                  controller.bornInHerdController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Renk',
                value: controller.colorController,
                options: ['Beyaz', 'Siyah'],
                onSelected: (value) {
                  controller.colorController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Oluşma Şekli',
                value: controller.formationTypeController,
                options: ['Suni Tohumlama', 'Doğal Aşım', 'Embriyo Transferi'],
                onSelected: (value) {
                  controller.formationTypeController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Boynuz',
                value: controller.hornController,
                options: ['Var', 'Yok'],
                onSelected: (value) {
                  controller.hornController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Doğum Türü',
                value: controller.birthTypeController,
                options: ['Normal', 'Sezaryen'],
                onSelected: (value) {
                  controller.birthTypeController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Sigorta',
                value: controller.insuranceController,
                options: ['Evet', 'Hayır'],
                onSelected: (value) {
                  controller.insuranceController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'İkizlik',
                value: controller.twinsController,
                options: ['Evet', 'Hayır'],
                onSelected: (value) {
                  controller.twinsController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Cinsiyet',
                value: controller.genderController,
                options: ['Erkek', 'Dişi'],
                onSelected: (value) {
                  controller.genderController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildTextField(
                label: 'Devlet Küpe No',
                controller: controller.govTagNoController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildTimeField(
                label: 'Doğum Saati',
                controller: controller.timeController,
                onTap: utils.showTimePicker,
              ),
              SizedBox(height: 16),
              BuildCounterField(
                label: 'Hayvan Tipi Skoru',
                controller: controller.typeController,
                title: 'hayvan',
              ),
              SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
                child: FormButton(
                  title: 'Güncelle',
                  onPressed: () {
                    if (controller.formKey.currentState!.validate()) {
                      controller.updateAnimalDetails(tableName, animalId);
                      Get.back(result: true);
                      Get.snackbar('Başarılı', 'Güncelleme Kaydedildi', duration: Duration(milliseconds: 1800));
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

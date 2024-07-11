import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildCounterField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildDateField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildSelectionField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildTextField.dart';
import 'package:merlabciftlikyonetim/FormFields/BuildTimeField.dart';
import 'package:merlabciftlikyonetim/FormFields/FormButton.dart';
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
                options: ['Durum1', 'Durum2'], // Adjust with real options
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
              BuildSelectionField(
                label: 'Irk',
                value: controller.speciesController,
                options: ['Türk Koyunu', 'Merinos','Çine Çoban Koyunu'], // Adjust with real options
                onSelected: (value) {
                  controller.speciesController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildTextField(
                label: 'Ahır / Bölme',
                controller: controller.stallController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildTextField(
                label: 'Grup',
                controller: controller.groupController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildTextField(
                label: 'Notlar',
                controller: controller.notesController,
                hint: '',
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Ana ID',
                value: controller.motherController,
                options: ['Ana1', 'Ana2'], // Adjust with real options
                onSelected: (value) {
                  controller.motherController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Baba ID',
                value: controller.fatherController,
                options: ['Baba1', 'Baba2'], // Adjust with real options
                onSelected: (value) {
                  controller.fatherController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Sürüde doğdu',
                value: controller.bornInHerdController,
                options: ['Evet', 'Hayır'], // Adjust with real options
                onSelected: (value) {
                  controller.bornInHerdController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Renk',
                value: controller.colorController,
                options: ['Beyaz', 'Siyah'], // Adjust with real options
                onSelected: (value) {
                  controller.colorController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Oluşma Şekli',
                value: controller.formationTypeController,
                options: ['Doğal', 'Yapay'], // Adjust with real options
                onSelected: (value) {
                  controller.formationTypeController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Boynuz',
                value: controller.hornController,
                options: ['Var', 'Yok'], // Adjust with real options
                onSelected: (value) {
                  controller.hornController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Doğum Türü',
                value: controller.birthTypeController,
                options: ['Normal', 'Sezaryen'], // Adjust with real options
                onSelected: (value) {
                  controller.birthTypeController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Sigorta',
                value: controller.insuranceController,
                options: ['Evet', 'Hayır'], // Adjust with real options
                onSelected: (value) {
                  controller.insuranceController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'İkizlik',
                value: controller.twinsController,
                options: ['Evet', 'Hayır'], // Adjust with real options
                onSelected: (value) {
                  controller.twinsController.value = value;
                },
              ),
              SizedBox(height: 16),
              BuildSelectionField(
                label: 'Cinsiyet',
                value: controller.genderController,
                options: ['Erkek', 'Dişi'], // Adjust with real options
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

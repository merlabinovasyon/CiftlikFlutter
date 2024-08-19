import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../AnimalService/AnimalService.dart';
import 'AnimalDiseaseController.dart';
import 'DatabaseAddAnimalDiseaseHelper.dart';

class AddAnimalDiseaseController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var notes = ''.obs;
  var diseaseType = Rxn<String>();
  var date = ''.obs;

  var diseases = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchDiseaseList();
  }

  void fetchDiseaseList() async {
    diseases.assignAll(await AnimalService.instance.getDiseaseList());
  }

  void resetForm() {
    notes.value = '';
    diseaseType.value = null;
    date.value = '';
  }

  void addDisease(String tagNo) async {
    final diseaseController = Get.find<AnimalDiseaseController>();
    final diseaseDetails = {
      'tagNo': tagNo,
      'date': date.value,
      'diseaseName': diseaseType.value,
      'notes': notes.value,
    };

    int id = await DatabaseAddAnimalDiseaseHelper.instance.addDisease(diseaseDetails);

    diseaseController.addDisease(
      Disease(
        id: id,
        tagNo: tagNo,
        date: date.value,
        diseaseName: diseaseType.value,
        notes: notes.value,
      ),
    );

    diseaseController.fetchDiseasesByTagNo(tagNo);
  }
}

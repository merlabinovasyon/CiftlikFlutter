import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalExaminationController.dart';

class AddAnimalExaminationController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var notes = ''.obs;
  var examType = Rxn<String>();
  var date = ''.obs; // Tarihi tutmak için yeni bir değişken ekledik

  void resetForm() {
    notes.value = '';
    examType.value = null;
    date.value = ''; // Tarih alanını da sıfırla
  }

  void addExamination() {
    final examController = Get.find<AnimalExaminationController>();
    examController.examinations.add(
      Examination(
        date: date.value,
        examName: examType.value,
        notes: notes.value,
      ),
    );
  }
}

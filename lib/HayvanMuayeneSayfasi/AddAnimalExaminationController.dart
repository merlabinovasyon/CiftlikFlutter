import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalExaminationController.dart';
import 'DatabaseAddAnimalExaminationHelper.dart';

class AddAnimalExaminationController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var notes = ''.obs;
  var examType = Rxn<String>();
  var date = ''.obs;

  void resetForm() {
    notes.value = '';
    examType.value = null;
    date.value = '';
  }

  void addExamination(String tagNo) async {
    final examController = Get.find<AnimalExaminationController>();
    final examDetails = {
      'tagNo': tagNo,
      'date': date.value,
      'examName': examType.value,
      'notes': notes.value,
    };

    int id = await DatabaseAddAnimalExaminationHelper.instance.addExamination(examDetails);

    examController.addExamination(
      Examination(
        id: id,
        tagNo: tagNo,
        date: date.value,
        examName: examType.value,
        notes: notes.value,
      ),
    );

    examController.fetchExaminationsByTagNo(tagNo);
  }
}

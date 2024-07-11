import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalVaccineController.dart'; // AnimalVaccineController ve Vaccine modelini burada import ediyoruz
import 'DatabaseAddAnimalVaccineHelper.dart';

class AddAnimalVaccineController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var notes = ''.obs;
  var vaccineType = Rxn<String>();
  var date = ''.obs; // Tarihi tutmak için yeni bir değişken ekledik

  void resetForm() {
    notes.value = '';
    vaccineType.value = null;
    date.value = ''; // Tarih alanını da sıfırla
  }

  void addVaccine(String tagNo) async {
    final vaccineController = Get.find<AnimalVaccineController>();
    final vaccineDetails = {
      'tagNo': tagNo,
      'date': date.value,
      'vaccineName': vaccineType.value,
      'notes': notes.value,
    };

    int id = await DatabaseAddAnimalVaccineHelper.instance.addVaccine(vaccineDetails);

    vaccineController.addVaccine(
      Vaccine(
        id: id,
        tagNo: tagNo,
        date: date.value,
        vaccineName: vaccineType.value,
        notes: notes.value,
      ),
    );

    // Eklemeden sonra listeyi güncelle
    vaccineController.fetchVaccinesByTagNo(tagNo);
  }
}

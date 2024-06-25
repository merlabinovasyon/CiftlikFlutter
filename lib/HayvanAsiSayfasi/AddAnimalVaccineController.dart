import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalVaccineController.dart'; // AnimalVaccineController ve Vaccine modelini burada import ediyoruz

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

  void addVaccine() {
    // AnimalVaccineController'daki aşı listesine aşı ekleyin
    final vaccineController = Get.find<AnimalVaccineController>();
    vaccineController.vaccines.add(
      Vaccine(
        date: date.value,
        vaccineName: vaccineType.value,
        notes: notes.value,
      ),
    );
  }
}

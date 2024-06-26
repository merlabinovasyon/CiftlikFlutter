import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'PregnancyCheckController.dart';

class AddPregnancyCheckController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var notes = ''.obs;
  var kontrolSonucu = Rxn<String>();
  var date = ''.obs;

  void resetForm() {
    notes.value = '';
    kontrolSonucu.value = null;
    date.value = '';
  }

  void addKontrol() {
    final kontrolController = Get.find<PregnancyCheckController>();
    kontrolController.kontrols.add(
      Kontrol(
        date: date.value,
        kontrolSonucu: kontrolSonucu.value,
        notes: notes.value,
      ),
    );
  }
}

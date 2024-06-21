import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddVaccineController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var vaccineName = ''.obs;
  var vaccineDescription = ''.obs;

  void resetForm() {
    vaccineName.value = '';
    vaccineDescription.value = '';
  }
}

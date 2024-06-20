import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddDiseaseController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var diseaseName = ''.obs;
  var diseaseDescription = ''.obs;

  void resetForm() {
    diseaseName.value = '';
    diseaseDescription.value = '';
  }
}

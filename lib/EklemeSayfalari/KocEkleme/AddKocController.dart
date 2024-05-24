import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddKocController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();

  var selectedKoc = Rxn<String>();

  final List<String> koc = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];

  @override
  void onClose() {
    dobController.dispose();
    timeController.dispose();
    countController.dispose();
    super.onClose();
  }

  void resetForm() {
    selectedKoc.value = null;
    dobController.clear();
    timeController.clear();
    countController.clear();
  }
}

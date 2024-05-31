import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddBogaController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();

  var selectedBoga = Rxn<String>();

  final List<String> boga = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];

  @override
  void onClose() {
    dobController.dispose();
    timeController.dispose();
    countController.dispose();
    super.onClose();
  }

  void resetForm() {
    selectedBoga.value = null;
    dobController.clear();
    timeController.clear();
    countController.clear();
  }
}

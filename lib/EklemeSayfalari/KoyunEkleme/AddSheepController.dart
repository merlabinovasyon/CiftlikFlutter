import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddSheepController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();

  var selectedSheep = Rxn<String>();

  final List<String> sheep = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];

  @override
  void onClose() {
    dobController.dispose();
    timeController.dispose();
    countController.dispose();
    super.onClose();
  }

  void resetForm() {
    selectedSheep.value = null;
    dobController.clear();
    timeController.clear();
    countController.clear();
  }
}

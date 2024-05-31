import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddInekController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();

  var selectedInek = Rxn<String>();

  final List<String> inek = ['Merinos', 'Türk Koyunu', 'Çine Çoban Koyunu'];

  @override
  void onClose() {
    dobController.dispose();
    timeController.dispose();
    countController.dispose();
    super.onClose();
  }

  void resetForm() {
    selectedInek.value = null;
    dobController.clear();
    timeController.clear();
    countController.clear();
  }
}

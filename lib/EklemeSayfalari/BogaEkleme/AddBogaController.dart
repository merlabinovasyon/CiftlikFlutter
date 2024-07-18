import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/EklemeSayfalari/BogaEkleme/DatabaseBogaHelper.dart';
import '../../AnimalService/AnimalService.dart';

class AddBogaController extends GetxController {
  final formKey = GlobalKey<FormState>();
  final dobController = TextEditingController();
  final timeController = TextEditingController();
  final countController = TextEditingController();
  final tagNoController = TextEditingController();
  final govTagNoController = TextEditingController();
  final nameController = TextEditingController();

  var selectedBoga = Rxn<String>();
  var selectedBogaId = Rxn<int>();  // Yeni alan

  var species = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBogaSpeciesList();
  }

  @override
  void dispose() {
    dobController.dispose();
    timeController.dispose();
    countController.dispose();
    tagNoController.dispose();
    govTagNoController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void fetchBogaSpeciesList() async {
    species.assignAll(await AnimalService.instance.getBogaSpeciesList());
  }

  void resetForm() {
    selectedBoga.value = null;
    selectedBogaId.value = null;
    dobController.clear();
    timeController.clear();
    countController.clear();
    tagNoController.clear();
    govTagNoController.clear();
    nameController.clear();
  }

  Future<void> saveBogaData() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();

      Map<String, dynamic> bogaData = {
        'weight': double.tryParse(countController.text) ?? 0.0,
        'tagNo': tagNoController.text,
        'govTagNo': govTagNoController.text,
        'species': selectedBoga.value ?? '',
        'animalsubtypeid': selectedBogaId.value,
        'name': nameController.text,
        'dob': dobController.text,
        'time': timeController.text,
      };

      await DatabaseBogaHelper.instance.insertBoga(bogaData);
      Get.snackbar('Başarılı', 'Kayıt başarılı');
      Future.delayed(const Duration(seconds: 1), () {
        Get.offAllNamed('/bottomNavigation');
      });
    }
  }
}

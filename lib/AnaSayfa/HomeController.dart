import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/DatabaseService.dart';

class HomeController extends GetxController {
  final DatabaseService _databaseService = Get.find();
  var isSearching = false.obs; // Arama durumunu takip eder

  Future<void> addAnimalType(Map<String, dynamic> animalData, BuildContext context) async {
    await _databaseService.addAnimalType(animalData, context);
  }

  Future<List<Map<String, dynamic>>> getAnimalTypes() async {
    return await _databaseService.getAnimalTypesFromSQLite();
  }

  @override
  void onInit() {
    super.onInit();
    _databaseService.initializeDatabase();
  }

  void clearSearch() {
    isSearching.value = false;
  }
}

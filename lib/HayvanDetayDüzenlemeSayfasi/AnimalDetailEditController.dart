import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../HayvanDetaySayfasi/DatabaseAnimalDetailHelper.dart';

class AnimalDetailEditController extends GetxController {
  final formKey = GlobalKey<FormState>();

  var tagNoController = TextEditingController();
  var nameController = TextEditingController();
  var dobController = TextEditingController();
  var status = Rxn<String>();
  var beltNoController = TextEditingController();
  var lakNoController = TextEditingController();
  var pedometerController = TextEditingController();
  var speciesController = Rxn<String>();
  var stallController = TextEditingController();
  var groupController = TextEditingController();
  var notesController = TextEditingController();
  var motherController = Rxn<String>();
  var fatherController = Rxn<String>();
  var bornInHerdController = Rxn<String>();
  var colorController = Rxn<String>();
  var formationTypeController = Rxn<String>();
  var hornController = Rxn<String>();
  var birthTypeController = Rxn<String>();
  var insuranceController = Rxn<String>();
  var twinsController = Rxn<String>();
  var genderController = Rxn<String>();
  var govTagNoController = TextEditingController();
  var timeController = TextEditingController();
  var typeController = TextEditingController();

  void loadAnimalDetails(String tableName, int animalId) async {
    var details = await DatabaseAnimalDetailHelper.instance.getAnimalDetails(tableName, animalId);
    if (details != null) {
      tagNoController.text = details['tagNo'] ?? '';
      nameController.text = details['name'] ?? '';
      dobController.text = details['dob'] ?? '';
      status.value = details['status'] ?? '';
      beltNoController.text = details['beltNo'] ?? '';
      lakNoController.text = details['lakNo'] ?? '';
      pedometerController.text = details['pedometer'] ?? '';
      speciesController.value = details['species'] ?? '';
      stallController.text = details['stall'] ?? '';
      groupController.text = details['group'] ?? '';
      notesController.text = details['notes'] ?? '';
      motherController.value = details['mother'] ?? '';
      fatherController.value = details['father'] ?? '';
      bornInHerdController.value = details['bornInHerd'] ?? '';
      colorController.value = details['color'] ?? '';
      formationTypeController.value = details['formationType'] ?? '';
      hornController.value = details['horn'] ?? '';
      birthTypeController.value = details['birthType'] ?? '';
      insuranceController.value = details['insurance'] ?? '';
      twinsController.value = details['twins'] ?? '';
      genderController.value = details['gender'] ?? '';
      govTagNoController.text = details['govTagNo'] ?? '';
      timeController.text = details['time'] ?? '';
      typeController.text = details['type']!.toString() ;
    }
  }

  void updateAnimalDetails(String tableName, int animalId) async {
    if (formKey.currentState!.validate()) {
      var updatedDetails = {
        'tagNo': tagNoController.text,
        'name': nameController.text,
        'dob': dobController.text,
        'status': status.value,
        'beltNo': beltNoController.text,
        'lakNo': lakNoController.text,
        'pedometer': pedometerController.text,
        'species': speciesController.value,
        'stall': stallController.text,
        'group': groupController.text,
        'notes': notesController.text,
        'mother': motherController.value,
        'father': fatherController.value,
        'bornInHerd': bornInHerdController.value,
        'color': colorController.value,
        'formationType': formationTypeController.value,
        'horn': hornController.value,
        'birthType': birthTypeController.value,
        'insurance': insuranceController.value,
        'twins': twinsController.value,
        'gender': genderController.value,
        'govTagNo': govTagNoController.text,
        'time': timeController.text,
        'type': int.parse(typeController.text),
      };
      await DatabaseAnimalDetailHelper.instance.updateAnimalDetails(tableName, animalId, updatedDetails);
    }
  }
}

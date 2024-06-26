import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalLocationController.dart';

class AddAnimalLocationController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var date = ''.obs;
  var location = Rxn<String>();

  void resetForm() {
    date.value = '';
    location.value = null;
  }

  void addLocation() {
    final locationController = Get.find<AnimalLocationController>();
    locationController.locations.add(
      Location(
        date: date.value,
        locationName: location.value,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../AnimalService/AnimalService.dart';
import 'AnimalLocationController.dart';
import 'DatabaseAddAnimalLocationHelper.dart';

class AddAnimalLocationController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var date = ''.obs;
  var location = Rxn<String>();

  var locations = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchLocationList();
  }

  void fetchLocationList() async {
    locations.assignAll(await AnimalService.instance.getLocationList());
  }

  void resetForm() {
    date.value = '';
    location.value = null;
  }

  void addLocation(String tagNo) async {
    final locationController = Get.find<AnimalLocationController>();
    final locationDetails = {
      'tagNo': tagNo,
      'date': date.value,
      'locationName': location.value,
    };

    int id = await DatabaseAddAnimalLocationHelper.instance.addLocation(locationDetails);

    locationController.addLocation(
      Location(
        id: id,
        tagNo: tagNo,
        date: date.value,
        locationName: location.value,
      ),
    );

    locationController.fetchLocationsByTagNo(tagNo);
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AnimalGroupController extends GetxController {
  var groups = <String>[].obs; // Mevcut grupların listesi
  var selectedGroup = Rxn<String>();
  var formKey = GlobalKey<FormState>(); // Form anahtarı

  // Kullanılabilir gruplar listesi
  List<String> availableGroups = [
    'Grup 1',
    'Grup 2',
    'Grup 3',
    // Daha fazla grup eklenebilir...
  ];

  void saveGroup() {
    if (formKey.currentState!.validate()) {
      String groupToSave = selectedGroup.value?.isNotEmpty == true ? selectedGroup.value! : 'Bilinmiyor';
      groups.add(groupToSave);
    }
  }

  void removeGroup(String group) {
    groups.remove(group);
    Get.snackbar('Başarılı', 'Grup silindi');
  }

  void resetForm() {
    selectedGroup.value = null;
  }
}

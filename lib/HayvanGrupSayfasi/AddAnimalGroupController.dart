import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalGroupController.dart';
import 'DatabaseAddAnimalGroupHelper.dart';

class AddAnimalGroupController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var selectedGroup = Rxn<String>();

  void resetForm() {
    selectedGroup.value = null;
  }

  Future<void> addGroup(String tagNo) async {
    final groupController = Get.find<AnimalGroupController>();

    if (selectedGroup.value == null || selectedGroup.value!.isEmpty) {
      Get.snackbar('Hata', 'Lütfen bir grup seçin');
      return;
    }

    final groupDetails = {
      'tagNo': tagNo,
      'groupName': selectedGroup.value,
    };

    int id = await DatabaseAddAnimalGroupHelper.instance.addGroup(groupDetails);

    groupController.addGroup(
      AnimalGroup(
        id: id,
        tagNo: tagNo,
        groupName: selectedGroup.value!,
      ),
    );

    // Listeyi güncelle
    await groupController.fetchGroupsByTagNo(tagNo);
  }
}

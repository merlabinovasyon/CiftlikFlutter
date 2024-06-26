import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalNoteController.dart';

class AddAnimalNoteController extends GetxController {
  var formKey = GlobalKey<FormState>();
  var notes = ''.obs;
  var date = ''.obs;

  void resetForm() {
    notes.value = '';
    date.value = '';
  }

  void addNote() {
    final noteController = Get.find<AnimalNoteController>();
    noteController.notes.add(
      AnimalNote(
        date: date.value,
        notes: notes.value,
      ),
    );
  }
}

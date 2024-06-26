import 'package:get/get.dart';

class AnimalNoteController extends GetxController {
  var notes = <AnimalNote>[].obs;

  @override
  void onInit() {
    super.onInit();
    notes.assignAll([
      AnimalNote(
        date: '10/06/2024',
        notes: 'Aa',
      ),
      // Daha fazla not eklenebilir
    ]);
  }

  void removeNote (AnimalNote note) {
    notes.remove(note);
  }
}

class AnimalNote {
  final String date;
  final String notes;

  AnimalNote({
    required this.date,
    required this.notes,
  });
}

import 'package:get/get.dart';

class AnimalExaminationController extends GetxController {
  var examinations = <Examination>[].obs;

  @override
  void onInit() {
    super.onInit();
    examinations.assignAll([
      Examination(
        date: '20/06/2024',
        examName: 'Dış Parazit',
        notes: 'Bb',
      ),
    ]);
  }

  void removeExamination(Examination examination) {
    examinations.remove(examination);
  }
}

class Examination {
  final String date;
  final String? examName;
  final String notes;

  Examination({
    required this.date,
    required this.examName,
    required this.notes,
  });
}

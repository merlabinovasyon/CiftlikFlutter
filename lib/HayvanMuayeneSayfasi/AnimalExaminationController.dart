import 'package:get/get.dart';
import 'DatabaseAddAnimalExaminationHelper.dart';

class AnimalExaminationController extends GetxController {
  var examinations = <Examination>[].obs;

  void fetchExaminationsByTagNo(String tagNo) async {
    var examData = await DatabaseAddAnimalExaminationHelper.instance.getExaminationsByTagNo(tagNo);
    if (examData.isNotEmpty) {
      examinations.assignAll(examData.map((data) => Examination.fromMap(data)).toList());
    } else {
      examinations.clear();
    }
  }

  void removeExamination(int id) async {
    await DatabaseAddAnimalExaminationHelper.instance.deleteExamination(id);
    var removedExamination = examinations.firstWhereOrNull((examination) => examination.id == id);
    if (removedExamination != null) {
      fetchExaminationsByTagNo(removedExamination.tagNo);
      Get.snackbar('Başarılı', 'Muayene silindi');
    }
  }

  void addExamination(Examination examination) {
    examinations.add(examination);
  }
}

class Examination {
  final int id;
  final String tagNo;
  final String date;
  final String? examName;
  final String notes;

  Examination({
    required this.id,
    required this.tagNo,
    required this.date,
    required this.examName,
    required this.notes,
  });

  factory Examination.fromMap(Map<String, dynamic> map) {
    return Examination(
      id: map['id'],
      tagNo: map['tagNo'],
      date: map['date'],
      examName: map['examName'],
      notes: map['notes'],
    );
  }
}

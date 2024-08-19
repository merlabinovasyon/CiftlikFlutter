import 'package:get/get.dart';
import 'DatabaseExaminationHelper.dart';

class ExaminationController extends GetxController {
  var examinations = <Examination>[].obs;
  var isLoading = true.obs;
  var searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchExaminations();
  }

  void fetchExaminations() async {
    isLoading.value = true;
    List<Map<String, dynamic>> examinationMaps = await DatabaseExaminationHelper.instance.getExaminations();
    examinations.assignAll(examinationMaps.map((examinationMap) => Examination.fromMap(examinationMap)).toList());
    isLoading.value = false;
  }

  void removeExamination(Examination examination) async {
    await DatabaseExaminationHelper.instance.deleteExamination(examination.id);
    examinations.remove(examination);
  }

  List<Examination> get filteredExaminations {
    if (searchQuery.value.isEmpty) {
      return examinations;
    } else {
      return examinations
          .where((examination) => examination.examinationName.toLowerCase().contains(searchQuery.value.toLowerCase()))
          .toList();
    }
  }
}

class Examination {
  final int id;
  final String examinationName;
  final String examinationDescription;

  Examination({
    required this.id,
    required this.examinationName,
    required this.examinationDescription,
  });

  factory Examination.fromMap(Map<String, dynamic> map) {
    return Examination(
      id: map['id'],
      examinationName: map['examinationName'],
      examinationDescription: map['examinationDescription'],
    );
  }
}

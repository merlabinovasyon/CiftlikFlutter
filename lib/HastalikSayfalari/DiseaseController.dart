import 'package:get/get.dart';
import 'DatabaseDiseaseHelper.dart';

class DiseaseController extends GetxController {
  var diseases = <Disease>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchDiseases();
  }

  Future<void> fetchDiseases() async {
    isLoading.value = true;
    List<Map<String, dynamic>> diseaseMaps = await DatabaseDiseaseHelper.instance.getDiseases();
    diseases.assignAll(diseaseMaps.map((diseaseMap) => Disease.fromMap(diseaseMap)).toList());
    isLoading.value = false;
  }

  void removeDisease(Disease disease) async {
    await DatabaseDiseaseHelper.instance.deleteDisease(disease.id);
    diseases.remove(disease);
  }
}

class Disease {
  final int id;
  final String diseaseName;
  final String diseaseDescription;

  Disease({
    required this.id,
    required this.diseaseName,
    required this.diseaseDescription,
  });

  factory Disease.fromMap(Map<String, dynamic> map) {
    return Disease(
      id: map['id'],
      diseaseName: map['diseaseName'],
      diseaseDescription: map['diseaseDescription'],
    );
  }
}

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

  void fetchDiseases() async {
    isLoading.value = true;
    List<Map<String, dynamic>> diseaseMaps = await DatabaseDiseaseHelper.instance.getDiseases();
    diseases.assignAll(diseaseMaps.map((diseaseMap) => Disease.fromMap(diseaseMap)).toList());
    isLoading.value = false;
  }
}

class Disease {
  final String diseaseName;
  final String diseaseDescription;

  Disease({
    required this.diseaseName,
    required this.diseaseDescription,
  });

  factory Disease.fromMap(Map<String, dynamic> map) {
    return Disease(
      diseaseName: map['diseaseName'],
      diseaseDescription: map['diseaseDescription'],
    );
  }
}

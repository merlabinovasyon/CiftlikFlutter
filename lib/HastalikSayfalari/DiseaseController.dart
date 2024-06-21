import 'package:get/get.dart';

class DiseaseController extends GetxController {
  var diseases = <Disease>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Örnek veri; gerçek verilerle değiştirin
    diseases.assignAll([
      Disease(
        diseaseName: 'Hastalık 1',
        diseaseDescription: 'Hastalık 1 açıklaması',
        image: 'resimler/login_screen_2.png',
      ),
      Disease(
        diseaseName: 'Hastalık 2',
        diseaseDescription: 'Hastalık 2 açıklaması',
        image: 'resimler/login_screen_2.png',
      ),
      Disease(
        diseaseName: 'Hastalık 3',
        diseaseDescription: 'Hastalık 3 açıklaması',
        image: 'resimler/login_screen_2.png',
      ),
      // Daha fazla hastalık ekleyin
    ]);
  }
}

class Disease {
  final String diseaseName;
  final String diseaseDescription;
  final String image;

  Disease({
    required this.diseaseName,
    required this.diseaseDescription,
    required this.image,
  });
}

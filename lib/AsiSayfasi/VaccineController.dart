import 'package:get/get.dart';

class VaccineController extends GetxController {
  var vaccines = <Vaccine>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Örnek veri; gerçek verilerle değiştirin
    vaccines.assignAll([
      Vaccine(
        vaccineName: 'Aşı 1',
        vaccineDescription: 'Aşı 1 açıklaması',
        image: 'resimler/login_screen_2.png',
      ),
      Vaccine(
        vaccineName: 'Aşı 2',
        vaccineDescription: 'Aşı 2 açıklaması',
        image: 'resimler/login_screen_2.png',
      ),
      Vaccine(
        vaccineName: 'Aşı 3',
        vaccineDescription: 'Aşı 3 açıklaması',
        image: 'resimler/login_screen_2.png',
      ),
      // Daha fazla aşı ekleyin
    ]);
  }
}

class Vaccine {
  final String vaccineName;
  final String vaccineDescription;
  final String image;

  Vaccine({
    required this.vaccineName,
    required this.vaccineDescription,
    required this.image,
  });
}

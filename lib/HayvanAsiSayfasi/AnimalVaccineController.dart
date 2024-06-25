import 'package:get/get.dart';

class AnimalVaccineController extends GetxController {
  var vaccines = <Vaccine>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Örnek veri; gerçek verilerle değiştirin
    vaccines.assignAll([
      Vaccine(
        date: '20/06/2024',
        vaccineName: 'Botulismus Aşısı',
        notes: 'Aa',
      ),
      // Daha fazla aşı ekleyin
    ]);
  }

  void removeVaccine(Vaccine vaccine) {
    vaccines.remove(vaccine);
  }
}

class Vaccine {
  final String date;
  final String? vaccineName;
  final String notes;

  Vaccine({
    required this.date,
    required this.vaccineName,
    required this.notes,
  });
}

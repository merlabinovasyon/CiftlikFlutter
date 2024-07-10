import 'package:get/get.dart';
import 'DatabaseVaccineHelper.dart';

class VaccineController extends GetxController {
  var vaccines = <Vaccine>[].obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchVaccines();
  }

  void fetchVaccines() async {
    isLoading.value = true;
    List<Map<String, dynamic>> vaccineMaps = await DatabaseVaccineHelper.instance.getVaccines();
    vaccines.assignAll(vaccineMaps.map((vaccineMap) => Vaccine.fromMap(vaccineMap)).toList());
    isLoading.value = false;
  }

  void removeVaccine(Vaccine vaccine) async {
    await DatabaseVaccineHelper.instance.deleteVaccine(vaccine.id);
    vaccines.remove(vaccine);
  }
}

class Vaccine {
  final int id;
  final String vaccineName;
  final String vaccineDescription;

  Vaccine({
    required this.id,
    required this.vaccineName,
    required this.vaccineDescription,
  });

  factory Vaccine.fromMap(Map<String, dynamic> map) {
    return Vaccine(
      id: map['id'],
      vaccineName: map['vaccineName'],
      vaccineDescription: map['vaccineDescription'],
    );
  }
}

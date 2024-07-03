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
}

class Vaccine {
  final String vaccineName;
  final String vaccineDescription;

  Vaccine({
    required this.vaccineName,
    required this.vaccineDescription,
  });

  factory Vaccine.fromMap(Map<String, dynamic> map) {
    return Vaccine(
      vaccineName: map['vaccineName'],
      vaccineDescription: map['vaccineDescription'],
    );
  }
}

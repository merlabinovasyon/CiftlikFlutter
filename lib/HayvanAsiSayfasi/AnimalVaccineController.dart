import 'package:get/get.dart';
import 'DatabaseAddAnimalVaccineHelper.dart';

class AnimalVaccineController extends GetxController {
  var vaccines = <Vaccine>[].obs;

  void fetchVaccinesByTagNo(String tagNo) async {
    var vaccineData = await DatabaseAddAnimalVaccineHelper.instance.getVaccinesByTagNo(tagNo);
    if (vaccineData.isNotEmpty) {
      vaccines.assignAll(vaccineData.map((data) => Vaccine.fromMap(data)).toList());
    } else {
      vaccines.clear();
    }
  }

  void removeVaccine(int id) async {
    await DatabaseAddAnimalVaccineHelper.instance.deleteVaccine(id);
    var removedVaccine = vaccines.firstWhereOrNull((vaccine) => vaccine.id == id);
    if (removedVaccine != null) {
      fetchVaccinesByTagNo(removedVaccine.tagNo);
      Get.snackbar('Başarılı', 'Aşı silindi');
    }
  }

  void addVaccine(Vaccine vaccine) {
    vaccines.add(vaccine);
  }
}

class Vaccine {
  final int id;
  final String tagNo;
  final String date;
  final String? vaccineName;
  final String notes;

  Vaccine({
    required this.id,
    required this.tagNo,
    required this.date,
    required this.vaccineName,
    required this.notes,
  });

  factory Vaccine.fromMap(Map<String, dynamic> map) {
    return Vaccine(
      id: map['id'],
      tagNo: map['tagNo'],
      date: map['date'],
      vaccineName: map['vaccineName'],
      notes: map['notes'],
    );
  }
}

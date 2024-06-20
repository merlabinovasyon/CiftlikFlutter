import 'package:get/get.dart';

class KonumController extends GetxController {
  var ahirList = <String>[].obs;
  var bolmeList = <Map<String, String>>[].obs;
  var selectedAhir = ''.obs;

  void addAhir(String ahir) {
    ahirList.add(ahir);
  }

  void updateAhir(int index, String newAhir) {
    String oldAhir = ahirList[index];
    ahirList[index] = newAhir;
    bolmeList.forEach((bolme) {
      if (bolme['ahir'] == oldAhir) {
        bolme['ahir'] = newAhir;
      }
    });
    selectAhir(newAhir); // Yeni ahır adı seçili kalır
  }

  void removeAhir(int index) {
    String ahir = ahirList[index];
    ahirList.removeAt(index);
    bolmeList.removeWhere((bolme) => bolme['ahir'] == ahir);
    if (selectedAhir.value == ahir) {
      selectedAhir.value = '';
    }
  }

  void addBolme(String ahir, String bolme) {
    bolmeList.add({'ahir': ahir, 'bolme': bolme});
  }

  void removeBolme(String ahir, String bolme) {
    bolmeList.removeWhere((b) => b['ahir'] == ahir && b['bolme'] == bolme);
  }

  void selectAhir(String ahir) {
    selectedAhir.value = ahir;
  }
}

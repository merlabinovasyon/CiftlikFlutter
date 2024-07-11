import 'package:get/get.dart';
import 'DatabaseKonumYonetimiHelper.dart';

class KonumController extends GetxController {
  var ahirList = <Map<String, dynamic>>[].obs;
  var bolmeList = <Map<String, dynamic>>[].obs;
  var selectedAhirId = Rxn<int>();

  @override
  void onInit() {
    super.onInit();
    fetchAhirList();
  }

  void fetchAhirList() async {
    var data = await DatabaseKonumYonetimiHelper.instance.getAhirList();
    ahirList.assignAll(data);
  }

  Future<int> addAhir(String name) async {
    int id = await DatabaseKonumYonetimiHelper.instance.addAhir(name);
    ahirList.add({'id': id, 'name': name});
    return id; // Yeni eklenen ahırın ID'sini döndür
  }

  void updateAhir(int index, String newName) async {
    int id = ahirList[index]['id'];
    await DatabaseKonumYonetimiHelper.instance.updateAhir(id, newName);

    // Ahır listesini güncellemek için geçici bir liste kullanarak
    List<Map<String, dynamic>> tempList = List.from(ahirList);
    tempList[index] = {'id': id, 'name': newName};
    ahirList.assignAll(tempList);  // Güncellenmiş listeyi tekrar ata
  }

  void removeAhir(int index) async {
    int id = ahirList[index]['id'];
    await DatabaseKonumYonetimiHelper.instance.removeAhir(id);
    ahirList.removeAt(index);
    if (selectedAhirId.value == id) {
      selectedAhirId.value = null;
    }
    fetchAhirList();
  }

  void addBolme(int ahirId, String name) async {
    int id = await DatabaseKonumYonetimiHelper.instance.addBolme(ahirId, name);
    bolmeList.add({'id': id, 'ahirId': ahirId, 'name': name});
  }

  void fetchBolmeList(int ahirId) async {
    var data = await DatabaseKonumYonetimiHelper.instance.getBolmeList(ahirId);
    bolmeList.assignAll(data);
  }

  void removeBolme(int id) async {
    await DatabaseKonumYonetimiHelper.instance.removeBolme(id);
    bolmeList.removeWhere((bolme) => bolme['id'] == id);
  }

  void selectAhir(int ahirId) {
    selectedAhirId.value = ahirId;
    fetchBolmeList(ahirId);
  }
}

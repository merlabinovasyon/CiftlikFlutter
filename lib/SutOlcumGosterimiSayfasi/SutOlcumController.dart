import 'package:get/get.dart';
import '../EklemeSayfalari/InekSutOlcumEkleme/DatabaseSutOlcumInekHelper.dart';
import '../EklemeSayfalari/KoyunSutOlcumEkleme/DatabaseSutOlcumKoyunHelper.dart';


class SutOlcumController extends GetxController {
  var sutOlcumList = <Map<String, dynamic>>[].obs;
  var isLoading = false.obs;

  // Önceden yüklenmiş verileri tutmak için bir harita oluşturun
  Map<String, List<Map<String, dynamic>>> cachedSutOlcum = {};

  // Önbellek boyutunu sınırlayın
  final int cacheSizeLimit = 100;

  Future<void> fetchSutOlcum(String tableName) async {
    if (cachedSutOlcum.containsKey(tableName)) {
      // Eğer veriler önceden yüklenmişse, doğrudan önbellekten alın
      sutOlcumList.assignAll(cachedSutOlcum[tableName]!);
    } else {
      isLoading(true);
      try {
        List<Map<String, dynamic>> data;
        if (tableName == 'sutOlcumInekTable') {
          data = await DatabaseSutOlcumInekHelper.instance.getSutOlcumInek();
        } else {
          data = await DatabaseSutOlcumKoyunHelper.instance.getSutOlcumKoyun();
        }
        sutOlcumList.assignAll(data);
        // Verileri önbelleğe kaydedin
        cachedSutOlcum[tableName] = data.toList();

        // Önbellek boyutunu kontrol edin ve gerekirse temizleyin
        if (cachedSutOlcum.length > cacheSizeLimit) {
          cachedSutOlcum.remove(cachedSutOlcum.keys.first);
        }
      } finally {
        isLoading(false);
      }
    }
  }

  Future<void> removeSutOlcum(int id, String tableName) async {
    if (tableName == 'sutOlcumInekTable') {
      await DatabaseSutOlcumInekHelper.instance.deleteSutOlcumInek(id);
    } else {
      await DatabaseSutOlcumKoyunHelper.instance.deleteSutOlcumKoyun(id);
    }
    // Önce listedeki öğeyi çıkar
    sutOlcumList.removeWhere((sutOlcum) => sutOlcum['id'] == id);
    // Önbellekteki öğeyi de çıkar
    cachedSutOlcum[tableName]?.removeWhere((sutOlcum) => sutOlcum['id'] == id);
    // Önbelleği güncelle
    cachedSutOlcum[tableName] = cachedSutOlcum[tableName]?.toList() ?? [];
  }
}

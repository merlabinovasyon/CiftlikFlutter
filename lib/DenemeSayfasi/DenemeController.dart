import 'package:get/get.dart';
import '../id_generator.dart';

class DenemeController extends GetxController {
  var uniqueId = ''.obs;
  var generatedIds = <String>{}.obs; // Set kullanımı

  void generateUniqueId(String text) {
    String newId = generateNewUniqueId(text, generatedIds);

    if (newId != 'Yazı çok kısa') {
      uniqueId.value = newId;
      generatedIds.add(newId); // Oluşturulan ID'yi sete ekle
    } else {
      uniqueId.value = newId; // Hata mesajını da uniqueId'ye ata
    }
  }
}

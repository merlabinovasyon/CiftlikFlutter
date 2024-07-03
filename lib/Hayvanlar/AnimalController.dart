import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/Hayvanlar/DatabaseAnimalHelper.dart';

class AnimalController extends GetxController {
  var animals = <Animal>[].obs;
  var isLoading = false.obs;

  // Önceden yüklenmiş verileri tutmak için bir harita oluşturun
  Map<String, List<Animal>> cachedAnimals = {};

  // Önbellek boyutunu sınırlayın
  final int cacheSizeLimit = 100;

  Future<void> fetchAnimals(String tableName) async {
    if (cachedAnimals.containsKey(tableName)) {
      // Eğer veriler önceden yüklenmişse, doğrudan önbellekten alın
      animals.assignAll(cachedAnimals[tableName]!);
    } else {
      isLoading(true);
      try {
        List<Map<String, dynamic>> data = await DatabaseAnimalHelper.instance.getAnimals(tableName);
        List<Animal> fetchedAnimals = data.map((item) => Animal.fromMap(item, tableName)).toList();
        animals.assignAll(fetchedAnimals);
        // Verileri önbelleğe kaydedin
        cachedAnimals[tableName] = fetchedAnimals;

        // Önbellek boyutunu kontrol edin ve gerekirse temizleyin
        if (cachedAnimals.length > cacheSizeLimit) {
          cachedAnimals.remove(cachedAnimals.keys.first);
        }
      } finally {
        isLoading(false);
      }
    }
  }
}

class Animal {
  final String? tagNo;
  final String? name;
  final String? dob;
  final String? type;
  final String? date;

  Animal({
    this.tagNo,
    this.name,
    this.dob,
    this.type,
    this.date,
  });

  factory Animal.fromMap(Map<String, dynamic> map, String tableName) {
    if (tableName == 'weanedKuzuTable' || tableName == 'weanedBuzagiTable') {
      return Animal(
        type: map['type'],
        date: map['date'],
      );
    } else {
      return Animal(
        tagNo: map['tagNo'],
        name: map['name'],
        dob: map['dob'],
      );
    }
  }
}

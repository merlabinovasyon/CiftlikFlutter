import 'package:get/get.dart';
import 'DatabaseAnimalHelper.dart';

class AnimalController extends GetxController {
  var animals = <Animal>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs; // Arama sorgusu için RxString

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

  List<Animal> get filteredAnimals {
    if (searchQuery.value.isEmpty) {
      return animals;
    } else {
      return animals.where((animal) {
        return (animal.tagNo?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false) ||
            (animal.name?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false);
      }).toList();
    }
  }

  Future<void> removeAnimal(int id, String tableName) async {
    await DatabaseAnimalHelper.instance.deleteAnimal(id, tableName);
    // Önce listedeki hayvanı çıkar
    animals.removeWhere((animal) => animal.id == id);
    // Önbellekteki hayvanı da çıkar
    cachedAnimals[tableName]?.removeWhere((animal) => animal.id == id);
  }

  void updateAnimal(int id, String tableName, Map<String, dynamic> updatedDetails) {
    int index = animals.indexWhere((animal) => animal.id == id);
    if (index != -1) {
      Animal updatedAnimal = Animal.fromMap(updatedDetails, tableName);
      animals[index] = updatedAnimal;

      if (cachedAnimals.containsKey(tableName)) {
        List<Animal> cachedList = List<Animal>.from(cachedAnimals[tableName]!);
        int cachedIndex = cachedList.indexWhere((animal) => animal.id == id);
        if (cachedIndex != -1) {
          cachedList[cachedIndex] = updatedAnimal;
          cachedAnimals[tableName] = cachedList;
        }
      }
    }
  }
}

class Animal {
  final int id;
  final String? tagNo;
  final String? name;
  final String? dob;
  final String? date;

  Animal({
    required this.id,
    this.tagNo,
    this.name,
    this.dob,
    this.date,
  });

  factory Animal.fromMap(Map<String, dynamic> map, String tableName) {
    if (tableName == 'weanedKuzuTable' || tableName == 'weanedBuzagiTable') {
      return Animal(
        id: map['id'],
        tagNo: map['tagNo'],
        date: map['date'],
      );
    } else {
      return Animal(
        id: map['id'],
        tagNo: map['tagNo'],
        name: map['name'],
        dob: map['dob'],
      );
    }
  }
}

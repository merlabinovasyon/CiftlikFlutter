import 'package:get/get.dart';
import '../AnimalService/AnimalService.dart';
import 'DatabaseAnimalHelper.dart';

class AnimalController extends GetxController {
  var animals = <Animal>[].obs;
  var isLoading = false.obs;
  var searchQuery = ''.obs;
  var currentTableName = ''.obs;

  Map<String, List<Animal>> cachedAnimals = {};

  final int cacheSizeLimit = 100;

  Future<void> fetchAnimals(String tableName) async {
    currentTableName.value = tableName;
    if (cachedAnimals.containsKey(tableName)) {
      animals.assignAll(cachedAnimals[tableName]!);
    } else {
      isLoading(true);
      try {
        List<Map<String, dynamic>> data;
        switch (tableName) {
          case 'koyunTable':
            data = await AnimalService.instance.getKoyunAnimalList();
            break;
          case 'kocTable':
            data = await AnimalService.instance.getKocAnimalList();
            break;
          case 'inekTable':
            data = await AnimalService.instance.getInekAnimalList();
            break;
          case 'bogaTable':
            data = await AnimalService.instance.getBogaAnimalList();
            break;
          case 'lambTable':
            data = await AnimalService.instance.getKuzuAnimalList();
            break;
          case 'buzagiTable':
            data = await AnimalService.instance.getBuzagiAnimalList();
            break;
          case 'weanedKuzuTable':
          case 'weanedBuzagiTable':
            data = await DatabaseAnimalHelper.instance.getAnimals(tableName);
            break;
          default:
            data = await DatabaseAnimalHelper.instance.getAnimals(tableName);
        }
        List<Animal> fetchedAnimals = data.map((item) => Animal.fromMap(item, tableName)).toList();
        animals.assignAll(fetchedAnimals);
        cachedAnimals[tableName] = fetchedAnimals;

        if (cachedAnimals.length > cacheSizeLimit) {
          cachedAnimals.remove(cachedAnimals.keys.first);
        }
      } finally {
        isLoading(false);
      }
    }
    filterAnimals();
  }

  void filterAnimals() {
    if (searchQuery.value.isEmpty) {
      animals.refresh();
    } else {
      animals.assignAll(
        animals.where((animal) {
          return (animal.tagNo?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false) ||
              (animal.name?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false);
        }).toList(),
      );
    }
  }

  Future<String?> getAnimalTable(String tagNo) async {
    if (await isAnimalInTable(tagNo, 'weanedKuzuTable')) {
      return 'weanedKuzuTable';
    } else if (await isAnimalInTable(tagNo, 'weanedBuzagiTable')) {
      return 'weanedBuzagiTable';
    } else if (await isAnimalInTable(tagNo, 'Animal')) {
      return 'Animal';
    }
    return null;
  }

  Future<bool> isAnimalInTable(String tagNo, String tableName) async {
    var data = await DatabaseAnimalHelper.instance.getAnimalByTagNo(tableName, tagNo);
    return data != null;
  }

  Future<void> removeAnimal(int id, String tagNo) async {
    String? tableName = await getAnimalTable(tagNo);
    if (tableName != null) {
      print('Silinmeye çalışılan hayvan ID: $id, Tablonun adı: $tableName'); // Hayvan ID'sini ve tablo adını yazdırma
      await DatabaseAnimalHelper.instance.deleteAnimal(id, tableName);
      animals.removeWhere((animal) => animal.id == id);
      if (cachedAnimals.containsKey(tableName)) {
        cachedAnimals[tableName]?.removeWhere((animal) => animal.id == id);
      }
      // Önbelleği güncelle
      if (cachedAnimals.containsKey(currentTableName.value)) {
        cachedAnimals[currentTableName.value] = List<Animal>.from(animals);
      }
      animals.refresh(); // Listeyi hemen güncelle
    } else {
      print('Hayvan bulunamadı: ID $id, TagNo $tagNo');
    }
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

  List<Animal> get filteredAnimals => animals.where((animal) {
    return (animal.tagNo?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false) ||
        (animal.name?.toLowerCase().contains(searchQuery.value.toLowerCase()) ?? false);
  }).toList();
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
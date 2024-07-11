import 'package:get/get.dart';
import 'DatabaseAddAnimalLocationHelper.dart';

class AnimalLocationController extends GetxController {
  var locations = <Location>[].obs;

  void fetchLocationsByTagNo(String tagNo) async {
    var locationData = await DatabaseAddAnimalLocationHelper.instance.getLocationsByTagNo(tagNo);
    if (locationData.isNotEmpty) {
      locations.assignAll(locationData.map((data) => Location.fromMap(data)).toList());
    } else {
      locations.clear();
    }
  }

  void removeLocation(int id) async {
    await DatabaseAddAnimalLocationHelper.instance.deleteLocation(id);
    var removedLocation = locations.firstWhereOrNull((location) => location.id == id);
    if (removedLocation != null) {
      fetchLocationsByTagNo(removedLocation.tagNo);
      Get.snackbar('Başarılı', 'Lokasyon silindi');
    }
  }

  void addLocation(Location location) {
    locations.add(location);
  }
}

class Location {
  final int id;
  final String tagNo;
  final String date;
  final String? locationName;

  Location({
    required this.id,
    required this.tagNo,
    required this.date,
    required this.locationName,
  });

  factory Location.fromMap(Map<String, dynamic> map) {
    return Location(
      id: map['id'],
      tagNo: map['tagNo'],
      date: map['date'],
      locationName: map['locationName'],
    );
  }
}

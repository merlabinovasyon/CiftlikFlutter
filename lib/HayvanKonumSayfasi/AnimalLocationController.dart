import 'package:get/get.dart';

class AnimalLocationController extends GetxController {
  var locations = <Location>[].obs;

  @override
  void onInit() {
    super.onInit();
    locations.assignAll([
      Location(
        date: '10/06/2024',
        locationName: 'Bölme 1',
      ),
    ]);
  }

  void removeLocation(Location location) {
    locations.remove(location);
  }
}

class Location {
  final String date;
  final String? locationName;

  Location({
    required this.date,
    required this.locationName,
  });
}

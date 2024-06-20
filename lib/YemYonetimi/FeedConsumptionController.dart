import 'package:get/get.dart';

class FeedConsumptionController extends GetxController {
  var quantity = ''.obs;
  var totalCost = ''.obs;
  var notes = ''.obs;
  var date = '13/06/2024'.obs;

  void addFeedConsumption() {
    // Add feed consumption logic
    print('Feed consumed: $quantity kg for $totalCost');
  }
}

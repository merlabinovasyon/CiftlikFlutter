import 'package:get/get.dart';

class FeedPurchaseController extends GetxController {
  var quantity = ''.obs;
  var totalCost = ''.obs;
  var notes = ''.obs;
  var date = '13/06/2024'.obs;

  void addFeedPurchase() {
    // Add feed purchase logic
    print('Feed purchased: $quantity kg for $totalCost');
  }
}

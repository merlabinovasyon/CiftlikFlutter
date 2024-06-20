import 'package:get/get.dart';

import 'TransactionModel.dart';

class FeedDetailController extends GetxController {
  var transactions = <Transaction>[].obs;

  @override
  void onInit() {
    super.onInit();
    addSampleTransactions();
  }

  void deleteTransaction(String id) {
    transactions.removeWhere((transaction) => transaction.id == id);
  }

  void deleteAllTransactions() {
    transactions.clear();
  }

  void addSampleTransactions() {
    transactions.addAll([
      Transaction(
        id: '1',
        type: 'purchase',
        date: '13/06/2024',
        quantity: '80',
        notes: 'Aa',
        price: '550',
      ),
      Transaction(
        id: '2',
        type: 'consumption',
        date: '13/06/2024',
        quantity: '55',
        notes: 'Hh',
        price: '800',
      ),

    ]);
  }
}

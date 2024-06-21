import 'package:get/get.dart';

class Transaction {
  final String date;
  final String name;
  final String note;
  final double amount;
  final TransactionType type;

  Transaction({
    required this.date,
    required this.name,
    required this.note,
    required this.amount,
    required this.type,
  });
}

enum TransactionType { Gelir, Gider }

class FinanceController extends GetxController {
  var gelir = 0.0.obs;
  var gider = 0.0.obs;
  var bakiye = 0.0.obs;
  var transactions = <Transaction>[].obs;
  var selectedType = TransactionType.Gelir.obs;

  @override
  void onInit() {
    super.onInit();
    // Örnek verilerle başlatma
    transactions.assignAll([
      Transaction(date: '10 Haz 2024', name: 'Aa', note: 'Aa', amount: 400.0, type: TransactionType.Gelir),
      Transaction(date: '10 Haz 2024', name: 'Bb', note: 'Bb', amount: -200.0, type: TransactionType.Gider),
    ]);
    calculateTotals();
  }

  void calculateTotals() {
    gelir.value = transactions
        .where((transaction) => transaction.type == TransactionType.Gelir)
        .fold(0, (sum, transaction) => sum + transaction.amount);
    gider.value = transactions
        .where((transaction) => transaction.type == TransactionType.Gider)
        .fold(0, (sum, transaction) => sum + transaction.amount.abs());
    bakiye.value = gelir.value - gider.value;
  }

  void addTransaction(Transaction transaction) {
    transactions.add(transaction);
    calculateTotals();
  }

  void removeTransaction(Transaction transaction) {
    transactions.remove(transaction);
    calculateTotals();
  }
}

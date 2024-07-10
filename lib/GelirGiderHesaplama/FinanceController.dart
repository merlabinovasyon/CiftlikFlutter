import 'package:get/get.dart';
import 'DatabaseFinanceHelper.dart';

class Transaction {
  final int? id;
  final String date;
  final String name;
  final String note;
  final double amount;
  final TransactionType type;

  Transaction({
    this.id,
    required this.date,
    required this.name,
    required this.note,
    required this.amount,
    required this.type,
  });

  factory Transaction.fromMap(Map<String, dynamic> map) {
    return Transaction(
      id: map['id'],
      date: map['date'],
      name: map['name'],
      note: map['note'],
      amount: map['amount'],
      type: TransactionType.values.firstWhere((e) => e.toString() == 'TransactionType.${map['type']}'),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': date,
      'name': name,
      'note': note,
      'amount': amount,
      'type': type.toString().split('.').last,
    };
  }
}

enum TransactionType { Gelir, Gider }

class FinanceController extends GetxController {
  var gelir = 0.0.obs;
  var gider = 0.0.obs;
  var bakiye = 0.0.obs;
  var transactions = <Transaction>[].obs;
  var selectedType = TransactionType.Gelir.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchTransactions();
  }

  void fetchTransactions() async {
    isLoading.value = true;
    List<Map<String, dynamic>> transactionMaps = await DatabaseFinanceHelper.instance.getTransactions();
    transactions.assignAll(transactionMaps.map((transactionMap) => Transaction.fromMap(transactionMap)).toList());
    calculateTotals();
    isLoading.value = false;
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

  void addTransaction(Transaction transaction) async {
    int id = await DatabaseFinanceHelper.instance.insertTransaction(transaction.toMap());
    transaction = Transaction(
      id: id,
      date: transaction.date,
      name: transaction.name,
      note: transaction.note,
      amount: transaction.amount,
      type: transaction.type,
    );
    transactions.add(transaction);
    calculateTotals();
  }

  void removeTransaction(Transaction transaction) async {
    await DatabaseFinanceHelper.instance.deleteTransaction(transaction.id!);
    transactions.remove(transaction);
    calculateTotals();
  }
}

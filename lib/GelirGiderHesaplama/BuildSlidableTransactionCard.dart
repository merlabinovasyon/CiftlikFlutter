import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'FinanceController.dart';

class BuildSlidableTransactionCard extends StatelessWidget {
  final Transaction transaction;
  final FinanceController controller = Get.find();

  BuildSlidableTransactionCard({required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(transaction),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.17,
        children: [
          SlidableAction(
            onPressed: (context) {
              controller.removeTransaction(transaction);
              Get.snackbar('Başarılı', 'İşlem silindi');
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Sil',
            borderRadius: BorderRadius.circular(12.0),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      child: Card(
        elevation: 2,
        shadowColor: Colors.cyan,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          leading: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                transaction.date,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text(transaction.name),
            ],
          ),
          title: Row(
            children: [
              Expanded(child: Text(transaction.note)),
              Container(
                width: 1.0,
                height: 40.0,
                color: Colors.grey,
              ),
              SizedBox(width: 8.0),
              Text(
                'TRY ${transaction.amount.toStringAsFixed(2)}',
                style: TextStyle(
                  color: transaction.type == TransactionType.Gelir ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

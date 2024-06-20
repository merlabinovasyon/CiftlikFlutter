import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'FeedDetailController.dart';
import 'TransactionModel.dart';

class BuildSlidableTransactionFeedCard extends StatelessWidget {
  final Transaction transaction;
  final FeedDetailController controller;

  BuildSlidableTransactionFeedCard({required this.transaction, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(transaction.id),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.17,
        children: [
          SlidableAction(
            onPressed: (context) {
              controller.deleteTransaction(transaction.id);
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
        elevation: 4,
        shadowColor: Colors.cyan,
        color: Colors.white,
        margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: ListTile(
          leading: Icon(
            transaction.type == 'purchase' ? Icons.shopping_cart : Icons.remove_shopping_cart,
            color: Colors.orange,
          ),
          title: Text('${transaction.date} - ${transaction.type == 'purchase' ? 'Alış' : 'Tüketim'}'),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${transaction.quantity} kg'),
              Text('Notlar: ${transaction.notes}'),
            ],
          ),
          trailing: Text('${transaction.price} TRY', style: TextStyle(color: Colors.red)),
        ),
      ),
    );
  }
}

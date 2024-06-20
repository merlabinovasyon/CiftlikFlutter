import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'FinanceController.dart';

class BuildSummaryCard extends StatelessWidget {
  final String title;
  final double amount;
  final bool isIncome;
  final FinanceController controller = Get.find();

  BuildSummaryCard({required this.title, required this.amount, required this.isIncome});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        controller.selectedType.value = isIncome ? TransactionType.Gelir : TransactionType.Gider;
      },
      child: Obx(() {
        return Card(
          color: controller.selectedType.value == (isIncome ? TransactionType.Gelir : TransactionType.Gider)
              ? Colors.cyan[50]
              : Colors.white,
          shape: RoundedRectangleBorder(
            side: BorderSide(
              color: controller.selectedType.value == (isIncome ? TransactionType.Gelir : TransactionType.Gider)
                  ? Colors.black87
                  : Colors.transparent,
              width: 2.0,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          elevation: 2.0,
          child: Container(
            width: 150,
            padding: EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title),
                SizedBox(height: 4.0),
                Text(
                  'TRY ${amount.toStringAsFixed(2)}',
                  style: TextStyle(
                    color: isIncome ? Colors.green : Colors.red,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}

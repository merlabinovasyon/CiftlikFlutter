import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'FinanceController.dart';
import 'AddTransactionPage.dart';
import 'BuildSummaryCard.dart';
import 'BuildSlidableTransactionCard.dart';

class FinancePage extends StatelessWidget {
  final FinanceController controller = Get.put(FinanceController());

  FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () {
            Get.back();
          },
        ),
        title: Center(
          child: Container(
            height: 40,
            width: 130,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('resimler/logo_v2.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.add, size: 30,),
            onPressed: () {
              Get.to(AddTransactionPage(),duration: Duration(milliseconds: 650));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Obx(() {
              return Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.cyan, Colors.blue.withOpacity(0.9)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                    ),
                    width: double.infinity,
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Güncel Bakiye', style: TextStyle(color: Colors.white)),
                        Text(
                          'TRY ${controller.bakiye.value.toStringAsFixed(2)}',
                          style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      BuildSummaryCard(title: 'Gelir', amount: controller.gelir.value, isIncome: true),
                      BuildSummaryCard(title: 'Gider', amount: controller.gider.value, isIncome: false),
                    ],
                  ),
                ],
              );
            }),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  hintText: 'Tarih, Ad, Notlar',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                ),
              ),
            ),
            Obx(() {
              final filteredTransactions = controller.transactions.where((transaction) {
                return transaction.type == controller.selectedType.value;
              }).toList();
              return ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: filteredTransactions.length,
                itemBuilder: (context, index) {
                  final transaction = filteredTransactions[index];
                  return BuildSlidableTransactionCard(transaction: transaction);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}

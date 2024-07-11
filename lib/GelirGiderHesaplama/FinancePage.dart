import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart'; // Import the intl package
import 'FinanceController.dart';
import 'AddTransactionPage.dart';
import 'BuildSummaryCard.dart';
import 'BuildSlidableTransactionCard.dart';

class FinancePage extends StatelessWidget {
  final FinanceController controller = Get.put(FinanceController());

  FinancePage({super.key});

  @override
  Widget build(BuildContext context) {
    final formatter = NumberFormat.currency(locale: 'tr_TR', symbol: '', decimalDigits: 2);

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
              Get.to(AddTransactionPage(), duration: Duration(milliseconds: 650));
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator(color: Colors.black,));
        } else {
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
                      'TRY ${formatter.format(controller.bakiye.value)}',
                      style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 5,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  BuildSummaryCard(
                    title: 'Gelir',
                    amount: controller.gelir.value,
                    isIncome: true,
                    assetPath: 'icons/graph_with_income_arrow_icon_white_bg.png',
                  ),
                  BuildSummaryCard(
                    title: 'Gider',
                    amount: controller.gider.value,
                    isIncome: false,
                    assetPath: 'icons/graph_with_downward_arrow_straight_icon.png',
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    hintText: 'Tarih, Ad, Notlar',
                    border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.0)),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  onChanged: (value) {
                    controller.searchQuery.value = value;
                  },
                ),
              ),
              Expanded(
                child: Obx(() {
                  final filteredTransactions = controller.filteredTransactions;

                  if (filteredTransactions.isEmpty) {
                    return Center(
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(
                          controller.selectedType.value == TransactionType.Gelir
                              ? 'Gelir işlemi henüz eklenmedi.'
                              : 'Gider işlemi henüz eklenmedi.',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: filteredTransactions.length,
                      itemBuilder: (context, index) {
                        final transaction = filteredTransactions[index];
                        return BuildSlidableTransactionCard(transaction: transaction);
                      },
                    );
                  }
                }),
              ),
            ],
          );
        }
      }),
    );
  }
}

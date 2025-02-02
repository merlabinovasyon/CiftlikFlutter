import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/YemYonetimi/FeedConsumptionPage.dart';
import 'package:merlabciftlikyonetim/YemYonetimi/FeedPurchasePage.dart';
import 'FeedDetailController.dart';
import 'TransactionModel.dart';
import 'BuildSlidableTransactionFeedCard.dart'; // Yeni widget'ı import ettik

class FeedDetailPage extends StatelessWidget {
  final FeedDetailController controller = Get.put(FeedDetailController());

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
            icon: Icon(Icons.delete, size: 30),
            onPressed: () {
              // Delete all functionality
              Get.defaultDialog(
                backgroundColor: Colors.white,
                title: "Silme İşlemi",
                middleText: "Tüm işlemleri silmek istediğinize emin misiniz?",
                textConfirm: "Evet",
                textCancel: "Hayır",
                confirmTextColor: Colors.white,
                onConfirm: () {
                  controller.deleteAllTransactions();
                  Get.back();
                  Get.snackbar('Başarılı', 'Tüm İşlemler Silindi');
                },
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4,
                    shadowColor: Colors.cyan, // Gölge rengi cyan olarak ayarlandı
                    child: InkWell(
                      onTap: () {
                        // Alış ekleme işlemi
                        Get.to(() => FeedPurchasePage(), duration: Duration(milliseconds: 650));
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Alış Ekle', style: TextStyle(fontSize: 16)),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4,
                    shadowColor: Colors.cyan, // Gölge rengi cyan olarak ayarlandı
                    child: InkWell(
                      onTap: () {
                        // Tüketim ekleme işlemi
                        Get.to(() => FeedConsumptionPage(), duration: Duration(milliseconds: 650));
                      },
                      borderRadius: BorderRadius.circular(8.0),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 16.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Tüketim Ekle', style: TextStyle(fontSize: 16)),
                            Icon(Icons.arrow_forward_ios, size: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Card(
              color: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              elevation: 4,
              shadowColor: Colors.cyan, // Gölge rengi cyan olarak ayarlandı
              child: InkWell(
                onTap: () {
                  // Yem bileşimleri değeri düzenleme işlemi
                },
                borderRadius: BorderRadius.circular(8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit, size: 16),
                      const SizedBox(width: 8),
                      Text('Düzenle Yem Bileşimleri Değeri', style: TextStyle(fontSize: 16)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Text('Geçmiş İşlemler', style: TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.transactions.isEmpty) {
                  return Center(
                    child: Text(
                      'Bu yemle alakalı geçmiş işleminiz bulunmamaktadır.',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                      textAlign: TextAlign.center, // Yazıyı ortalar
                    ),
                  );
                }
                return ListView.builder(
                  itemCount: controller.transactions.length,
                  itemBuilder: (context, index) {
                    final transaction = controller.transactions[index];
                    return BuildSlidableTransactionFeedCard(transaction: transaction, controller: controller);
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

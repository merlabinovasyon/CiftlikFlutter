import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'FeedDetailPage.dart';
import 'FeedController.dart';
import 'TransactionModel.dart';

class FeedStockCard extends StatelessWidget {
  final Map<String, dynamic> feed;

  const FeedStockCard({required this.feed});

  @override
  Widget build(BuildContext context) {
    final FeedController controller = Get.find<FeedController>();

    return StreamBuilder<Transaction?>(
      stream: controller.getLastTransactionStream(feed['id']),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator(color: Colors.black,); // Veriler yüklenirken göstermek için
        }

        Transaction? lastTransaction = snapshot.data;

        return StreamBuilder<double?>(
          stream: controller.getTotalKgStream(feed['id']),
          builder: (context, totalKgSnapshot) {
            double totalKg = totalKgSnapshot.data ?? 0.0;

            return Slidable(
              key: ValueKey(feed['id']),
              endActionPane: ActionPane(
                motion: ScrollMotion(),
                extentRatio: 0.17,
                children: [
                  SlidableAction(
                    onPressed: (context) {
                      controller.removeFeedStock(feed['id']);
                      Get.snackbar('Başarılı', 'Yem silindi');
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
              child: Stack(
                children: [
                  Card(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    elevation: 4,
                    shadowColor: Colors.cyan,
                    child: ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15.0),
                      ),
                      leading: Image.asset(
                        'icons/clover_icon_black.png',
                        width: 55,
                        height: 55,
                      ),
                      title: Text(feed['feedName'], style: TextStyle(fontWeight: FontWeight.bold)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Toplam ${totalKg} kg'),
                          if (lastTransaction != null)
                            Text(
                              '${lastTransaction.quantity} kg, ₺${lastTransaction.price}',
                              style: TextStyle(
                                color: lastTransaction.type == 'purchase' ? Colors.green : Colors.red,
                              ),
                            ),
                          if (lastTransaction == null)
                            Text(
                              'Son İşlem Bilgisi Bulunmamaktadır.',
                              style: TextStyle(color: Colors.red),
                            ),
                        ],
                      ),
                      trailing: Icon(Icons.arrow_forward_ios),
                      onTap: () {
                        Get.to(() => FeedDetailPage(feedId: feed['id']), duration: Duration(milliseconds: 650));
                      },
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 13,
                    child: Icon(
                      Icons.swipe_left,
                      size: 18,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}

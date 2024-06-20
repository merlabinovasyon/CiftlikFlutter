import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'FeedController.dart';
import 'FeedDetailController.dart';
import 'FeedDetailPage.dart';

class FeedStockPage extends StatelessWidget {
  final FeedController controller = Get.put(FeedController());

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
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Ara...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
              ),
              onChanged: (value) {
                // Arama işlevini burada uygulayın
              },
            ),
            const SizedBox(height: 16),
            Obx(() => Align(
              alignment: Alignment.centerRight,
              child: Text('Toplam ${controller.totalStock} Stok', style: TextStyle(fontWeight: FontWeight.bold)),
            )),
            const SizedBox(height: 16),
            Expanded(
              child: Obx(() {
                if (controller.feedList.isEmpty) {
                  return Center(child: Text('Lütfen bir yem stoğu ekleyin'));
                }
                return ListView.builder(
                  itemCount: controller.feedList.length,
                  itemBuilder: (context, index) {
                    var feed = controller.feedList[index];
                    return Card(
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      elevation: 4,
                      shadowColor: Colors.cyan, // Gölge rengi cyan olarak ayarlandı
                      child: ListTile(
                        leading: Image.asset(
                          'resimler/icons/clover_icon_black.png', // Kendi ikonunuzun yolu
                          width: 55, // İkon boyutunda olacak şekilde genişlik
                          height: 55, // İkon boyutunda olacak şekilde yükseklik
                        ),
                        title: Text(feed['name'], style: TextStyle(fontWeight: FontWeight.bold)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Toplam ${feed['weight']} kg'),
                            Text(feed['lastPurchase'], style: feed['lastPurchase'] == 'Son Satın Alım Bilgisi Bulunmamaktadır.' ? TextStyle(color: Colors.red) : null),
                            if (feed['quantity'] != '' && feed['price'] != '')
                              Text('${feed['quantity']}, ${feed['price']}', style: TextStyle(color: Colors.red)),
                          ],
                        ),
                        trailing: Icon(Icons.arrow_forward_ios),
                        onTap: () {
                          Get.to(() => FeedDetailPage(),duration: Duration(milliseconds: 650));
                        },
                      ),
                    );
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

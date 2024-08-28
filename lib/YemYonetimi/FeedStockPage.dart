import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddFeedPage.dart';
import 'FeedController.dart';
import 'FeedStockCard.dart';

class FeedStockPage extends StatelessWidget {
  final FeedController controller = Get.put(FeedController());
  final FocusNode searchFocusNode = FocusNode();

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
            onPressed: () async {
              final result = await Get.to(() => AddFeedPage(), duration: Duration(milliseconds: 650));
              if (result == true) {
                controller.fetchFeedStocks();
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              focusNode: searchFocusNode,
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search),
                hintText: 'Ara...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onChanged: (value) {
                controller.searchQuery.value = value; // Arama sorgusunu güncelle
              },
              onTapOutside: (event) {
                searchFocusNode.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
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
                var filteredList = controller.filteredFeedList; // Filtrelenmiş listeyi al
                if (filteredList.isEmpty) {
                  return Center(child: Text('Lütfen bir yem stoğu ekleyin'));
                }
                return ListView.builder(
                  itemCount: filteredList.length,
                  itemBuilder: (context, index) {
                    var feed = filteredList[index];
                    return FeedStockCard(feed: feed);
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

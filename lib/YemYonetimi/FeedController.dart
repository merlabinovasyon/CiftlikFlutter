import 'package:get/get.dart';

class FeedController extends GetxController {
  var feedList = <Map<String, dynamic>>[
    {'name': 'Arpa', 'weight': 75, 'lastPurchase': '13/06/2024', 'quantity': '80 kg', 'price': '\₺550'},
    {'name': 'Ayçi küsp. <5 HY, kabuksuz', 'weight': 0, 'lastPurchase': 'Son Satın Alım Bilgisi Bulunmamaktadır.', 'quantity': '', 'price': ''},
    {'name': 'Buğday kepeği durum', 'weight': -55, 'lastPurchase': 'Son Satın Alım Bilgisi Bulunmamaktadır.', 'quantity': '', 'price': ''},
    {'name': 'Buğday samanı', 'weight': 0, 'lastPurchase': 'Son Satın Alım Bilgisi Bulunmamaktadır.', 'quantity': '', 'price': ''},
    {'name': 'İtalyan ryegrass (kuru), ilk biçim, tarlada kurutma, %10 başaklanma', 'weight': 0, 'lastPurchase': 'Son Satın Alım Bilgisi Bulunmamaktadır.', 'quantity': '', 'price': ''},
  ].obs;

  var totalStock = 170.obs;
}

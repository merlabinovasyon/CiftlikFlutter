import 'package:get/get.dart';
import 'DatabaseFeedStockHelper.dart';
import 'TransactionModel.dart';

class FeedController extends GetxController {
  var feedList = <Map<String, dynamic>>[].obs;
  var totalStock = 0.obs;
  var searchQuery = ''.obs;
  final Map<int, Transaction?> lastTransactionCache = {}; // Son işlemleri önbellekte tutar
  final Map<int, double?> totalKgCache = {}; // Toplam kg değerlerini önbellekte tutar

  @override
  void onInit() {
    super.onInit();
    fetchFeedStocks();
  }

  void fetchFeedStocks() async {
    List<Map<String, dynamic>> feedStocks = await DatabaseFeedStockHelper.instance.getFeedStocks();
    feedList.assignAll(feedStocks);
    updateTotalStock();
  }

  void updateTotalStock() {
    totalStock.value = feedList.length;
  }

  void removeFeedStock(int id) async {
    await DatabaseFeedStockHelper.instance.deleteFeedStock(id);
    totalKgCache.remove(id); // Toplam kg önbelleğinden kaldır
    lastTransactionCache.remove(id); // Son işlem önbelleğinden kaldır
    fetchFeedStocks();
  }

  Stream<Transaction?> getLastTransactionStream(int feedId) async* {
    while (true) {
      Map<String, dynamic>? result = await DatabaseFeedStockHelper.instance.getLastTransactionByFeedId(feedId);

      if (result != null) {
        yield Transaction.fromMap(result); // Map verisini Transaction nesnesine dönüştürerek yield ediyoruz
      } else {
        yield null; // Eğer veri yoksa null döndürüyoruz
      }

      await Future.delayed(Duration(seconds: 2)); // Periyodik kontrol için gecikme ekliyoruz
    }
  }

  Stream<double?> getTotalKgStream(int feedId) async* {
    while (true) {
      double? totalKg = await DatabaseFeedStockHelper.instance.getNetQuantityByFeedId(feedId);

      if (totalKg != null) {
        totalKgCache[feedId] = totalKg; // Önbelleğe kaydet
        yield totalKgCache[feedId];
      } else {
        totalKgCache[feedId] = 0.0; // Eğer veri yoksa sıfır olarak kaydet
        yield totalKgCache[feedId];
      }

      await Future.delayed(Duration(seconds: 2)); // Periyodik kontrol için gecikme ekliyoruz
    }
  }

  void addTransaction(Transaction transaction) async {
    await DatabaseFeedStockHelper.instance.insertTransaction(transaction.toMap());
    lastTransactionCache.remove(transaction.feedId); // Önbellekteki işlemi güncellemek için kaldır
    totalKgCache.remove(transaction.feedId); // Toplam kg önbelleğini güncellemek için kaldır

    // Yeni verinin çekilmesi için stream'leri tetikle.
    fetchFeedStocks(); // Yem verilerini güncelle
    update(); // UI güncellenmesi için tetikle
  }

  List<Map<String, dynamic>> get filteredFeedList {
    if (searchQuery.value.isEmpty) {
      return feedList;
    } else {
      return feedList.where((feed) {
        return feed['feedName']
            .toString()
            .toLowerCase()
            .contains(searchQuery.value.toLowerCase());
      }).toList();
    }
  }
}

import 'package:get/get.dart';

class AnimalController extends GetxController {
  var animals = <Animal>[].obs;

  @override
  void onInit() {
    super.onInit();
    // Örnek veri; gerçek verilerle değiştirin
    animals.assignAll([
      Animal(
        koyun: 'Koyun 1',
        koc: 'Koç 1',
        dogumSaati: '10:00',
        dogumTarihi: '2023-01-01',
        kupeNo: '12345',
        devletKupeNo: '54321',
        hayvanAdi: 'Kuzu 1',
        cinsiyet: 'Erkek',
        kuzuTipi: 'Sütten Kesilmiş',
        image: 'resimler/icons/sheep_and_lamb_icon_black.png',
      ),
      Animal(
        koyun: 'Koyun 1',
        koc: 'Koç 1',
        dogumSaati: '10:00',
        dogumTarihi: '2023-01-01',
        kupeNo: '12345',
        devletKupeNo: '54321',
        hayvanAdi: 'Kuzu 1',
        cinsiyet: 'Erkek',
        kuzuTipi: 'Sütten Kesilmiş',
        image: 'resimler/icons/hornless_sheep_with_straight_ears_icon_black.png',
      ),
      Animal(
        koyun: 'Koyun 1',
        koc: 'Koç 1',
        dogumSaati: '10:00',
        dogumTarihi: '2023-01-01',
        kupeNo: '123456789',
        devletKupeNo: '54321',
        hayvanAdi: 'Kuzu 1',
        cinsiyet: 'Erkek',
        kuzuTipi: 'Sütten Kesilmiş',
        image: 'resimler/icons/hornless_sheep_with_straight_ears_icon_black.png',
      ),
      // Daha fazla hayvan ekleyin
    ]);
  }
}

class Animal {
  final String koyun;
  final String koc;
  final String dogumSaati;
  final String dogumTarihi;
  final String kupeNo;
  final String devletKupeNo;
  final String hayvanAdi;
  final String cinsiyet;
  final String kuzuTipi;
  final String image;

  Animal({
    required this.koyun,
    required this.koc,
    required this.dogumSaati,
    required this.dogumTarihi,
    required this.kupeNo,
    required this.devletKupeNo,
    required this.hayvanAdi,
    required this.cinsiyet,
    required this.kuzuTipi,
    required this.image,
  });
}

import 'package:get/get.dart';

class PregnancyCheckController extends GetxController {
  var kontrols = <Kontrol>[].obs;

  @override
  void onInit() {
    super.onInit();
    kontrols.assignAll([
      Kontrol(
        date: '26/06/2024',
        kontrolSonucu: 'Gebe Değil',
        notes: 'Aa',
      ),
    ]);
  }

  void removeKontrol(Kontrol kontrol) {
    kontrols.remove(kontrol);
  }
}

class Kontrol {
  final String date;
  final String? kontrolSonucu;
  final String notes;

  Kontrol({
    required this.date,
    required this.kontrolSonucu,
    required this.notes,
  });
}

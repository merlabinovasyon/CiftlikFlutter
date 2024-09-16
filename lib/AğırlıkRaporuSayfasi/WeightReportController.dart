import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeightReportController extends GetxController {
  var reports = <Map<String, dynamic>>[].obs;
  var isFilterApplied = false.obs; // Filtre uygulanıp uygulanmadığını izler
  var searchTerm = ''.obs; // Arama terimi için observable değişken

  // Arama terimine göre filtrelenmiş raporlar
  List<Map<String, dynamic>> get filteredReports {
    if (searchTerm.value.isEmpty) {
      return reports;
    } else {
      return reports.where((report) {
        String tagNo = report['tagNo']?.toString() ?? '';
        return tagNo.contains(searchTerm.value);
      }).toList();
    }
  }

  // Sonuçları rapor listesine ekleme
  void updateReports(List<Map<String, dynamic>> results) {
    // Aynı animalid'ye sahip verileri birleştir
    Map<String, Map<String, dynamic>> groupedReports = {};

    for (var result in results) {
      // Veritabanı sonuçlarını yeni bir Map'e kopyalayarak modifiye edilebilir hale getiriyoruz
      var modifiableResult = Map<String, dynamic>.from(result);

      String animalid = modifiableResult['animalid'].toString();
      if (groupedReports.containsKey(animalid)) {
        // Eğer aynı animalid'ye sahip veri varsa, diğer verilerle birleştir
        groupedReports[animalid]!.addAll(modifiableResult);
      } else {
        // Eğer aynı animalid'ye sahip veri yoksa yeni bir giriş yap
        groupedReports[animalid] = modifiableResult;
      }
    }

    // Sonuçları reports listesine aktar
    reports.assignAll(groupedReports.values.toList());

    // Filtre uygulandığında isFilterApplied değerini true yapıyoruz
    isFilterApplied.value = results.isNotEmpty;
  }

  // Filtreleri sıfırlama fonksiyonu
  void resetReports() {
    reports.clear();
    isFilterApplied.value = false; // Filtreyi sıfırla
    searchTerm.value = ''; // Arama terimini sıfırla
  }
}

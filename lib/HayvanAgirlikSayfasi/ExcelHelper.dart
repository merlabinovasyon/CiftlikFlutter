import 'package:excel/excel.dart';
import 'dart:io';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

class ExcelHelper {
  static Future<bool> requestPermissions() async {
    if (await Permission.manageExternalStorage.isGranted) {
      // Android 11 ve sonrası için gerekli izin zaten verilmişse devam edin
      return true;
    } else if (await Permission.manageExternalStorage.request().isGranted) {
      // Android 11 ve sonrası için gerekli izin verildiyse devam edin
      return true;
    } else if (await Permission.manageExternalStorage.isDenied) {
      // Android 11 ve sonrası için gerekli izin reddedildiyse kullanıcıya mesaj gösterin
      Get.snackbar('İzin Gerekli', 'Excel dosyası olarak kaydetmek için depolama izni gereklidir.');
      return false;
    }

    // Android 10 ve öncesi için gerekli izin kontrolü
    if (await Permission.storage.isGranted) {
      // Android 10 ve öncesi için gerekli izin zaten verilmişse devam edin
      return true;
    } else if (await Permission.storage.request().isGranted) {
      // Android 10 ve öncesi için gerekli izin verildiyse devam edin
      return true;
    } else if (await Permission.storage.isDenied) {
      // Android 10 ve öncesi için gerekli izin reddedildiyse kullanıcıya mesaj gösterin
      Get.snackbar('İzin Gerekli', 'Excel dosyası olarak kaydetmek için depolama izni gereklidir.');
      return false;
    }

    return false; // Herhangi bir izin verilmezse false döndür
  }



  static Future<void> exportToExcel(int animalId, List<dynamic> weights, String tagNo) async {
    // İzinleri kontrol edin ve isteyin
    bool isPermissionGranted = await requestPermissions();
    if (!isPermissionGranted) {
      return; // İzin verilmediyse işlemi durdur
    }

    if (weights.isEmpty) {
      Get.snackbar('Uyarı', 'Ağırlık verisi bulunamadı');
      return;
    }

    // /storage/emulated/0/Temp klasörünü al ve oluştur
    Directory tempDirectory = Directory('/storage/emulated/0/Temp');

    // Eğer Temp klasörü yoksa oluştur
    if (!(await tempDirectory.exists())) {
      await tempDirectory.create(recursive: true);
    }

    // Dosya yolu
    String outputPath = '${tempDirectory.path}/hayvan_agirliklari_$tagNo.xlsx';

    var excel = Excel.createExcel(); // Yeni bir Excel dosyası oluştur
    Sheet sheetObject = excel['Sheet1']; // İlk sayfayı seç

    // Başlık satırını ekleyin
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0)).value = TextCellValue('Küpe No');
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0)).value = TextCellValue('Ağırlık (kg)');
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0)).value = TextCellValue('Tarih');
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0)).value = TextCellValue('Ağırlık Değişimi (kg)');
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: 0)).value = TextCellValue('Ağırlık Değişimi Yüzdesi (%)');
    sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: 0)).value = TextCellValue('Gün Farkı');

    double? previousWeight;
    String? previousDate;

    for (int i = 0; i < weights.length; i++) {
      var weight = weights[i];
      double weightChange = 0.0;
      double weightChangePercentage = 0.0;
      int dayDifference = 0;

      // Eğer önceki bir ağırlık varsa farkları hesapla
      if (previousWeight != null && previousDate != null) {
        weightChange = weight.weight - previousWeight!;

        if (previousWeight != 0) {
          weightChangePercentage = (weightChange / previousWeight) * 100;
        }

        String formattedCurrentDate = convertDateToIsoFormat(weight.date); // Tarihi formatla
        String formattedPrevDate = convertDateToIsoFormat(previousDate); // Önceki tarihi formatla
        DateTime currentDate = DateTime.parse(formattedCurrentDate); // Mevcut tarihi al
        DateTime prevDate = DateTime.parse(formattedPrevDate); // Önceki tarihi al
        dayDifference = currentDate.difference(prevDate).inDays; // Gün farkını hesapla
      }

      // Satırı doldur
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1)).value = TextCellValue(tagNo); // Küpe No sütunu
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1)).value = DoubleCellValue(weight.weight);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1)).value = TextCellValue(weight.date);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1)).value = DoubleCellValue(weightChange);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1)).value = DoubleCellValue(weightChangePercentage);
      sheetObject.cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1)).value = IntCellValue(dayDifference);

      // Bir sonraki satır için önceki değerleri güncelle
      previousWeight = weight.weight;
      previousDate = weight.date;
    }

    // Dosyayı kaydedin
    try {
      File(outputPath)
        ..createSync(recursive: true)
        ..writeAsBytesSync(excel.encode()!);
      Get.snackbar('Başarılı', 'Excel dosyası kaydedildi: $outputPath');
      print('$outputPath');
    } catch (e) {
      print("Dosya kaydedilirken hata oluştu: $e");
      Get.snackbar('Hata', 'Dosya kaydedilemedi: $outputPath');
    }
  }

  static String convertDateToIsoFormat(String date) {
    // Ay isimlerini sayılara dönüştürme
    Map<String, String> months = {
      'Ocak': '01',
      'Şubat': '02',
      'Mart': '03',
      'Nisan': '04',
      'Mayıs': '05',
      'Haziran': '06',
      'Temmuz': '07',
      'Ağustos': '08',
      'Eylül': '09',
      'Ekim': '10',
      'Kasım': '11',
      'Aralık': '12',
    };

    // "23 Ağustos 2024" -> "2024-08-23"
    List<String> dateParts = date.split(' ');
    String day = dateParts[0];
    String month = months[dateParts[1]] ?? '01'; // Ay adını sayıya çevir
    String year = dateParts[2];

    return '$year-$month-${day.padLeft(2, '0')}'; // YYYY-MM-DD formatında döndür
  }
}

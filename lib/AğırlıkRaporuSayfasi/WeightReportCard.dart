import 'package:flutter/material.dart';
import 'package:get/get.dart';

class WeightReportCard extends StatelessWidget {
  final Map<String, dynamic> report;
  final int index;

  WeightReportCard({Key? key, required this.report, required this.index}) : super(key: key);

  // Verileri formatlamak için yardımcı fonksiyon
  Widget formatData(dynamic value, String label, String suffix, {bool isPercentageOrKg = false}) {
    if (value == null || value.toString().contains("gerekli") || value.toString().contains("bulunamadı")) {
      return Text(value.toString());
    } else {
      Color textColor = Colors.black;
      if (isPercentageOrKg && (value is double || value is int)) {
        textColor = value >= 0 ? Colors.green.shade700 : Colors.red;
      }

      return RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(color: Colors.black),
            ),
            TextSpan(
              text: '${value.toString()}',
              style: TextStyle(color: textColor),
            ),
            TextSpan(
              text: ' $suffix',
              style: TextStyle(color: textColor),
            ),
          ],
        ),
        softWrap: true,
      );
    }
  }

  // İlk harfi büyük yapma fonksiyonu
  String capitalize(String s) {
    if (s.isEmpty) return s;

    String firstChar = s[0];
    String restOfString = s.substring(1).toLowerCase();

    if (firstChar == 'i') {
      firstChar = 'İ'; // Küçük 'i' harfini büyük 'İ' yapıyoruz
    } else {
      firstChar = firstChar.toUpperCase();
    }

    return firstChar + restOfString;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 2.0,
      shadowColor: Colors.cyan,
      margin: const EdgeInsets.only(bottom: 10.0, right: 10),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Küpe No
            Row(
              children: [
                Icon(Icons.label_outline_rounded, color: Colors.black),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    'Küpe No: ${report['tagNo']}',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    softWrap: true,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),

            // Hayvan Türü (Eklendi)
            if (report.containsKey('animaltype')) ...[
              Row(
                children: [
                  Icon(Icons.pets, color: Colors.black),
                  SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Hayvan Türü: ${capitalize(report['animaltype'])}', // capitalize fonksiyonunu burada uyguladık
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],

            // Genel Ağırlık Değişimi
            if (report.containsKey('weight_diff_general')) ...[
              Row(
                children: [
                  Icon(Icons.scale, color: Colors.black),
                  SizedBox(width: 8),
                  Expanded(
                    child: formatData(report['weight_diff_general'], 'Genel Ağırlık Değişimi', 'kg', isPercentageOrKg: true),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.black),
                  SizedBox(width: 8),
                  Expanded(
                    child: formatData(report['weight_diff_percentage_general'], 'Genel Ağırlık Değişimi Yüzdesi', '%', isPercentageOrKg: true),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.black),
                  SizedBox(width: 8),
                  Expanded(
                    child: formatData(report['date_difference_general'], 'Genel Ağırlık Değişimindeki Gün Farkı', 'gün'),
                  ),
                ],
              ),
              SizedBox(height: 8),
            ],
            // Son Ağırlık Değişimi
            if (report.containsKey('weight_diff_last')) ...[
              Row(
                children: [
                  Icon(Icons.scale, color: Colors.black),
                  SizedBox(width: 8),
                  Expanded(
                    child: formatData(report['weight_diff_last'], 'Son Ağırlık Değişimi', 'kg', isPercentageOrKg: true),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.trending_up, color: Colors.black),
                  SizedBox(width: 8),
                  Expanded(
                    child: formatData(report['weight_diff_percentage_last'], 'Son Ağırlık Değişimi Yüzdesi', '%', isPercentageOrKg: true),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.calendar_today, color: Colors.black),
                  SizedBox(width: 8),
                  Expanded(
                    child: formatData(report['date_difference_last'], 'Son Ağırlık Değişimindeki Gün Farkı', 'gün'),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

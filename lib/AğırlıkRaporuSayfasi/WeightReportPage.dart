import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'WeightReportController.dart';
import 'WeightReportCard.dart';
import 'WeightReportFilterController.dart';
import 'WeightReportFilterPage.dart'; // Buraya FilterPage'i ekleyin

class WeightReportPage extends StatefulWidget {
  final String tagNo;

  WeightReportPage({Key? key, required this.tagNo}) : super(key: key);

  @override
  _WeightReportPageState createState() => _WeightReportPageState();
}

class _WeightReportPageState extends State<WeightReportPage> {
  final WeightReportController controller = Get.put(WeightReportController());
  final WeightReportFilterController filterController = Get.put(WeightReportFilterController());
  final FocusNode searchFocusNode = FocusNode();

  // Filtre sayfasını açan fonksiyon
  void showFilterSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Colors.white,
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      builder: (context) {
        return WeightReportFilterPage(); // Burada WeightReportFilterPage gösteriliyor
      },
    ).then((_) {
      // Filtre uygulanıp uygulanmadığı kontrol ediliyor
      if (controller.reports.isNotEmpty) {
        setState(() {
          controller.isFilterApplied.value = true; // Filtre uygulandığında bu değişkeni güncelle
        });
      }
    });
  }

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
            icon: Icon(Icons.filter_list, size: 30),
            onPressed: () {
              showFilterSheet(context); // Filtre sayfasını aç
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(() {
          if (!controller.isFilterApplied.value) {
            return Center(
              child: Text(
                'Lütfen raporunuzu görmek için filtreleme yapınız.',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            );
          } else if (controller.reports.isEmpty) {
            return Center(
              child: Text(
                'Kayıt bulunamadı',
                style: TextStyle(fontSize: 16, color: Colors.grey),
                textAlign: TextAlign.center,
              ),
            );
          } else {
            return Column(
              children: [
                TextField(
                  focusNode: searchFocusNode,
                  onChanged: (value) {
                    controller.searchTerm.value = value;
                  },
                  cursorColor: Colors.black54,
                  decoration: InputDecoration(
                    prefixIcon: const Icon(Icons.search),
                    hintText: 'Küpe No, Hayvan Türü',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8.0),
                      borderSide: BorderSide(color: Colors.black),
                    ),
                  ),
                  onTapOutside: (event) {
                    searchFocusNode.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
                  },
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: controller.filteredReports.length,
                    itemBuilder: (context, index) {
                      final report = controller.filteredReports[index];
                      return WeightReportCard(report: report, index: index);
                    },
                  ),
                ),
              ],
            );
          }
        }),
      ),
    );
  }
}

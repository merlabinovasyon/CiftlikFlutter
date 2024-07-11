import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../HayvanAsiSayfasi/AnimalVaccinePage.dart';
import '../HayvanDetayDüzenlemeSayfasi/AnimalDetailEditPage.dart';
import 'ActionsGrid.dart';
import 'ActivityRow.dart';
import 'AnimalDetailController.dart';
import 'CustomCard.dart';
import 'DetailRow.dart';
import 'ExpandableCard.dart';

class AnimalDetailPage extends StatefulWidget {
  final String tableName;
  final int animalId;

  AnimalDetailPage({required this.tableName, required this.animalId});

  @override
  _AnimalDetailPageState createState() => _AnimalDetailPageState();
}

class _AnimalDetailPageState extends State<AnimalDetailPage> {
  final AnimalDetailController controller = Get.put(AnimalDetailController());

  @override
  void initState() {
    super.initState();
    controller.fetchAnimalDetails(widget.tableName, widget.animalId);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back(result: controller.animalDetails);
        return false;
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          scrolledUnderElevation: 0.0,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            onPressed: () {
              Get.back(result: controller.animalDetails);
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
              icon: Icon(Icons.edit),
              onPressed: () async {
                var result = await Get.to(() => AnimalDetailEditPage(
                  tableName: widget.tableName,
                  animalId: widget.animalId,
                ));
                if (result == true) {
                  controller.fetchAnimalDetails(widget.tableName, widget.animalId);
                }
              },
            ),
          ],
        ),
        body: Obx(() {
          if (controller.animalDetails.isEmpty) {
            return Center(child: CircularProgressIndicator());
          } else {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[300],
                        ),
                        child: Icon(
                          Icons.image,
                          size: 50,
                          color: Colors.grey[700],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    CustomCard(
                      child: Column(
                        children: [
                          DetailRow(label1: 'Küpe No', value1: controller.animalDetails['tagNo'] ?? '', label2: 'Doğum Tarihi', value2: controller.animalDetails['dob'] ?? ''),
                          Divider(),
                          DetailRow(label1: 'Ad', value1: controller.animalDetails['name'] ?? '', label2: 'Durum', value2: controller.animalDetails['status'] ?? '...'),
                          Divider(),
                          DetailRow(label1: 'Kemer No', value1: controller.animalDetails['beltNo'] ?? '...', label2: 'Lak.no: 1 / 0 SGS', value2: controller.animalDetails['lakNo'] ?? '...'),
                          Divider(),
                          DetailRow(label1: 'Pedometre', value1: controller.animalDetails['pedometer'] ?? '...', label2: 'Irk', value2: controller.animalDetails['species'] ?? '...'),
                          Divider(),
                          DetailRow(label1: 'Ahır / Bölme', value1: controller.animalDetails['stall'] ?? '...', label2: 'Grup', value2: controller.animalDetails['group'] ?? '...'),
                          Divider(),
                          DetailRow(label1: 'Notlar', value1: controller.animalDetails['notes'] ?? '...', label2: '', value2: ''),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    ExpandableCard(
                      title: 'Diğer Bilgiler',
                      children: [
                        DetailRow(label1: 'Ana ID', value1: controller.animalDetails['mother'] ?? '...', label2: 'Sürüde doğdu', value2: controller.animalDetails['bornInHerd'] ?? '...'),
                        Divider(),
                        DetailRow(label1: 'Baba ID', value1: controller.animalDetails['father'] ?? '...', label2: 'Renk', value2: controller.animalDetails['color'] ?? '...'),
                        Divider(),
                        DetailRow(label1: 'Oluşma Şekli', value1: controller.animalDetails['formationType'] ?? '...', label2: 'Boynuz', value2: controller.animalDetails['horn'] ?? '...'),
                        Divider(),
                        DetailRow(label1: 'Doğum Türü', value1: controller.animalDetails['birthType'] ?? '...', label2: 'Sigorta', value2: controller.animalDetails['insurance'] ?? '...'),
                        Divider(),
                        DetailRow(label1: 'İkizlik', value1: controller.animalDetails['twins'] ?? '...', label2: 'Doğum Ağırlığı', value2: controller.animalDetails['birthWeight'] ?? '...'),
                        Divider(),
                        DetailRow(label1: 'Devlet Küpe No', value1: controller.animalDetails['govTagNo'] ?? '...', label2: 'Doğum Saati', value2: controller.animalDetails['time'] ?? '...'),
                        Divider(),
                        DetailRow(label1: 'Hayvan Tipi Skoru', value1: controller.animalDetails['type'] ?? '...', label2: 'Cinsiyet', value2: controller.animalDetails['gender'] ?? '...'),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ActionsGrid(),
                    const SizedBox(height: 16.0),
                    ExpandableCard(
                      title: 'Üreme Aktiviteleri',
                      children: [
                        ActivityRow(date: '10 Haz 2024', activity: 'Bugün'),
                        Divider(),
                        ActivityRow(date: '10 Haz 2024', activity: 'Doğum'),
                      ],
                    ),
                    const SizedBox(height: 16.0),
                    ElevatedButton(
                      onPressed: () {},
                      child: Text('Hayvanı Sil / Sürüden Çıkar'),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white, backgroundColor: Colors.red,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}

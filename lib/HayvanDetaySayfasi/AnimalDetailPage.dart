import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'ActionsGrid.dart';
import 'ActivityRow.dart';
import 'AnimalDetailController.dart';
import 'CustomCard.dart';
import 'DetailRow.dart';
import 'ExpandableCard.dart';


class AnimalDetailPage extends StatelessWidget {
  final AnimalDetailController controller = Get.put(AnimalDetailController());

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
            icon: Icon(Icons.edit),
            onPressed: () {
              // Düzenleme işlemi burada yapılabilir
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                    DetailRow(label1: 'Küpe No', value1: '5', label2: 'Doğum Tarihi', value2: '10/06/2024 -'),
                    Divider(),
                    DetailRow(label1: 'Ad', value1: 'Aa', label2: 'Durum', value2: 'Taze'),
                    Divider(),
                    DetailRow(label1: 'Kemer No', value1: '...', label2: 'Lak.no: 1 / 0 SGS', value2: '...'),
                    Divider(),
                    DetailRow(label1: 'Pedometre', value1: '...', label2: 'Irk', value2: 'Merinos'),
                    Divider(),
                    DetailRow(label1: 'Ahır / Bölme', value1: 'Bölme 1', label2: 'Grup', value2: 'Grup belirlenmemiş'),
                    Divider(),
                    DetailRow(label1: 'Notlar', value1: '...', label2: '', value2: ''),
                  ],
                ),
              ),
              const SizedBox(height: 16.0),
              ExpandableCard(
                title: 'Diğer Bilgiler',
                children: [
                  DetailRow(label1: 'Ana ID', value1: '...', label2: 'Sürüde doğdu', value2: '...'),
                  Divider(),
                  DetailRow(label1: 'Baba ID', value1: '...', label2: 'Renk', value2: '...'),
                  Divider(),
                  DetailRow(label1: 'Oluşma Şekli', value1: 'Doğal Aşım', label2: 'Boynuz', value2: 'Hayır'),
                  Divider(),
                  DetailRow(label1: 'Doğum Türü', value1: 'Normal Doğum', label2: 'Sigorta', value2: 'Evet'),
                  Divider(),
                  DetailRow(label1: 'İkizlik', value1: 'Farklı Cinsiyet(İkiz)', label2: 'Doğum Ağırlığı', value2: '...'),
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
      ),
    );
  }
}

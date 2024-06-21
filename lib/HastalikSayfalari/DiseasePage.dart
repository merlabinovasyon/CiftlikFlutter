import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/HastalikSayfalari/AddDiseasePage.dart';
import 'DiseaseCard.dart';
import 'DiseaseController.dart';

class DiseasePage extends StatefulWidget {
  DiseasePage({super.key});

  @override
  _DiseasePageState createState() => _DiseasePageState();
}

class _DiseasePageState extends State<DiseasePage> {
  final DiseaseController controller = Get.put(DiseaseController());

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
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0),
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
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              cursorColor: Colors.black54,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Hastalık Adı',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(color: Colors.black), // Odaklanıldığında border rengi
                ),
              ),
            ),
            const SizedBox(height: 8.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Hastalık ekleme işlemi burada yapılabilir
                    Get.to(() => AddDiseasePage(),duration: Duration(milliseconds: 650));
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.white,
                  ),
                  child: Row(
                    children: [
                      Text('Hastalık Ekle', style: TextStyle(color: Colors.black)),
                      Icon(Icons.add, color: Colors.black),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8.0),
            Expanded(
              child: Obx(
                    () => ListView.builder(
                  itemCount: controller.diseases.length,
                  itemBuilder: (context, index) {
                    final disease = controller.diseases[index];
                    return DiseaseCard(disease: disease);
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

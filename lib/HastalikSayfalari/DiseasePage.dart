import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:merlabciftlikyonetim/HastalikSayfalari/AddDiseasePage.dart';
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
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                hintText: 'Hastalık Adı',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
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

class DiseaseCard extends StatefulWidget {
  final Disease disease;

  const DiseaseCard({Key? key, required this.disease}) : super(key: key);

  @override
  _DiseaseCardState createState() => _DiseaseCardState();
}

class _DiseaseCardState extends State<DiseaseCard> {
  bool isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      elevation: 4.0,
      shadowColor: Colors.cyan,
      margin: const EdgeInsets.only(bottom: 10.0),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          onExpansionChanged: (bool expanding) => setState(() => isExpanded = expanding),
          leading: ClipRRect(
            borderRadius: BorderRadius.circular(15.0),
            child: Image.asset(
              widget.disease.image,
              height: 50,
              width: 50,
              fit: BoxFit.cover,
            ),
          ),
          title: Text(widget.disease.diseaseName),
          tilePadding: const EdgeInsets.symmetric(horizontal: 16.0),
          childrenPadding: const EdgeInsets.all(8.0),
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15.0),
              child: Image.asset(
                widget.disease.image,
                height: 100,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(widget.disease.diseaseDescription),
          ],
        ),
      ),
    );
  }
}
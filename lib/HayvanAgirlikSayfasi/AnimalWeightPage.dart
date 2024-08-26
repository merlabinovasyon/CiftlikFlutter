import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddAnimalWeightPage.dart';
import 'AnimalWeightController.dart';
import 'AnimalWeightCard.dart';
import 'AnimalWeightDetailCard.dart'; // Yeni kartı import etmeyi unutmayın

class AnimalWeightPage extends StatefulWidget {
  final int animalId;

  AnimalWeightPage({Key? key, required this.animalId}) : super(key: key);

  @override
  _AnimalWeightPageState createState() => _AnimalWeightPageState();
}

class _AnimalWeightPageState extends State<AnimalWeightPage> {
  final AnimalWeightController controller = Get.put(AnimalWeightController());

  @override
  void initState() {
    super.initState();
    controller.fetchWeightsByAnimalId(widget.animalId);
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
            icon: Icon(Icons.add, size: 30,),
            onPressed: () {
              Get.dialog(AddAnimalWeightPage(animalId: widget.animalId));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Yeni detay kartını burada gösteriyoruz
            AnimalWeightDetailCard(animalId: widget.animalId),
            const SizedBox(height: 16), // Araya biraz boşluk ekleyebiliriz
            Expanded(
              child: Obx(
                    () {
                  if (controller.weights.isEmpty) {
                    return Center(
                      child: Text(
                        'Ağırlık kaydı bulunamadı',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                        textAlign: TextAlign.center,
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: controller.weights.length,
                      itemBuilder: (context, index) {
                        final weight = controller.weights[index];
                        return AnimalWeightCard(weight: weight);
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

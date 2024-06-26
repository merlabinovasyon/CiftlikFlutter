import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddAnimalLocationPage.dart';
import 'AnimalLocationController.dart';
import 'AnimalLocationCard.dart';

class AnimalLocationPage extends StatefulWidget {
  AnimalLocationPage({Key? key}) : super(key: key);

  @override
  _AnimalLocationPageState createState() => _AnimalLocationPageState();
}

class _AnimalLocationPageState extends State<AnimalLocationPage> {
  final AnimalLocationController controller = Get.put(AnimalLocationController());

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
              Get.dialog(AddAnimalLocationPage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () {
            if (controller.locations.isEmpty) {
              return Center(
                child: Text(
                  'Lokasyon kaydı bulunamadı',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.locations.length,
                itemBuilder: (context, index) {
                  final location = controller.locations[index];
                  return AnimalLocationCard(location: location);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

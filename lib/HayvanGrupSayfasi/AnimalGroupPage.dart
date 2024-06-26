import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AnimalGroupController.dart';
import 'AddAnimalGroupPage.dart';
import 'AnimalGroupCard.dart';

class AnimalGroupPage extends StatelessWidget {
  final AnimalGroupController controller = Get.put(AnimalGroupController());

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
              Get.dialog(AddAnimalGroupPage());
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.groups.isEmpty) {
          return Center(child: Text('Grup kaydı bulunamadı',style: TextStyle(fontSize: 16, color: Colors.grey),
            textAlign: TextAlign.center,));
        } else {
          return ListView.builder(
            itemCount: controller.groups.length,
            itemBuilder: (context, index) {
              final group = controller.groups[index];
              return AnimalGroupCard(group: group);
            },
          );
        }
      }),
    );
  }
}

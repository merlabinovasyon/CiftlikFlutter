import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'KonumController.dart';
import 'BuildAhirList.dart';
import 'BuildBolmeList.dart';

class KonumYonetimiPage extends StatelessWidget {
  final KonumController controller = Get.put(KonumController());
  final TextEditingController ahirController = TextEditingController();
  final TextEditingController bolmeController = TextEditingController();

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
            BuildAhirList(controller: controller, ahirController: ahirController),
            SizedBox(height: 16),
            BuildBolmeList(controller: controller, bolmeController: bolmeController),
          ],
        ),
      ),
    );
  }
}

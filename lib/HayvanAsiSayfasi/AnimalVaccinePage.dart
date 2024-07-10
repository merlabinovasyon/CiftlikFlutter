import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddAnimalVaccinePage.dart';
import 'AnimalVaccineController.dart';
import 'AnimalVaccineCard.dart';

class AnimalVaccinePage extends StatefulWidget {
  final String tagNo;

  AnimalVaccinePage({Key? key, required this.tagNo}) : super(key: key);

  @override
  _AnimalVaccinePageState createState() => _AnimalVaccinePageState();
}

class _AnimalVaccinePageState extends State<AnimalVaccinePage> {
  final AnimalVaccineController controller = Get.put(AnimalVaccineController());

  @override
  void initState() {
    super.initState();
    controller.fetchVaccinesByTagNo(widget.tagNo);
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
              Get.dialog(AddAnimalVaccinePage(tagNo: widget.tagNo));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () {
            if (controller.vaccines.isEmpty) {
              return Center(
                child: Text(
                  'Aşı kaydı bulunamadı',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center, // Yazıyı ortalar
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.vaccines.length,
                itemBuilder: (context, index) {
                  final vaccine = controller.vaccines[index];
                  return AnimalVaccineCard(vaccine: vaccine);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddAnimalExaminationPage.dart';
import 'AnimalExaminationController.dart';
import 'AnimalExaminationCard.dart';

class AnimalExaminationPage extends StatefulWidget {
  final String tagNo;

  AnimalExaminationPage({Key? key, required this.tagNo}) : super(key: key);

  @override
  _AnimalExaminationPageState createState() => _AnimalExaminationPageState();
}

class _AnimalExaminationPageState extends State<AnimalExaminationPage> {
  final AnimalExaminationController controller = Get.put(AnimalExaminationController());

  @override
  void initState() {
    super.initState();
    controller.fetchExaminationsByTagNo(widget.tagNo);
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
              Get.dialog(AddAnimalExaminationPage(tagNo: widget.tagNo));
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () {
            if (controller.examinations.isEmpty) {
              return Center(
                child: Text(
                  'Muayene kaydı bulunamadı',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.examinations.length,
                itemBuilder: (context, index) {
                  final examination = controller.examinations[index];
                  return AnimalExaminationCard(examination: examination);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

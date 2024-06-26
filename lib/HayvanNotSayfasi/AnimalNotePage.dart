import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'AddAnimalNotePage.dart';
import 'AnimalNoteController.dart';
import 'AnimalNoteCard.dart';

class AnimalNotePage extends StatefulWidget {
  AnimalNotePage({Key? key}) : super(key: key);

  @override
  _AnimalNotePageState createState() => _AnimalNotePageState();
}

class _AnimalNotePageState extends State<AnimalNotePage> {
  final AnimalNoteController controller = Get.put(AnimalNoteController());

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
              Get.dialog(AddAnimalNotePage());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Obx(
              () {
            if (controller.notes.isEmpty) {
              return Center(
                child: Text(
                  'Not kaydı bulunamadı',
                  style: TextStyle(fontSize: 16, color: Colors.grey),
                  textAlign: TextAlign.center,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: controller.notes.length,
                itemBuilder: (context, index) {
                  final note = controller.notes[index];
                  return AnimalNoteCard(note: note);
                },
              );
            }
          },
        ),
      ),
    );
  }
}

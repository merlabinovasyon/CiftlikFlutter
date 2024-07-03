import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../HayvanDetaySayfasi/AnimalDetailPage.dart';
import 'AnimalController.dart';

class AnimalCard extends StatelessWidget {
  final Animal animal;
  final String tableName;

  const AnimalCard({Key? key, required this.animal, required this.tableName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => AnimalDetailPage(), duration: Duration(milliseconds: 650));
      },
      child: Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        elevation: 4.0,
        shadowColor: Colors.cyan,
        margin: const EdgeInsets.only(bottom: 10.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              CircleAvatar(
                radius: 30,
                backgroundColor: Colors.white,
                child: Image.asset(
                  'resimler/icons/sheep_and_lamb_icon_black.png',
                  width: 55,
                  height: 55,
                ),
              ),
              const SizedBox(width: 16.0),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: tableName == 'weaned'
                      ? [
                    Text(
                      'Hayvan: ${animal.type}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4.0),
                    Text(animal.date ?? ''),
                  ]
                      : [
                    Text(
                      'Küpe No: ${animal.tagNo}',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 4.0),
                    Text(animal.name ?? ''),
                    const SizedBox(height: 4.0),
                    Text(animal.dob ?? ''),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

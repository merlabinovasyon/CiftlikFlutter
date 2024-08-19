import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'AnimalVaccineController.dart';

class AnimalVaccineCard extends StatelessWidget {
  final Vaccine vaccine;
  final AnimalVaccineController controller = Get.put(AnimalVaccineController());

  AnimalVaccineCard({Key? key, required this.vaccine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(vaccine),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.17,
        children: [
          SlidableAction(
            onPressed: (context) {
              controller.removeVaccine(vaccine.id);
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Sil',
            borderRadius: BorderRadius.circular(12.0),
            padding: EdgeInsets.zero,
          ),
        ],
      ),
      child: Stack(
        children: [
          Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            elevation: 2.0,
            shadowColor: Colors.cyan,
            margin: const EdgeInsets.only(bottom: 10.0, right: 10),
            child: ListTile(
              leading: Image.asset(
                'icons/vaccine_syringe_icon_black.png', // Buraya asset yolunu koyun
                width: 35.0, // İstenilen genişliği belirleyin
                height: 35.0, // İstenilen yüksekliği belirleyin
              ),              title: Text(vaccine.date),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(vaccine.vaccineName ?? 'Bilinmiyor'), // Null kontrolü
                  Text(vaccine.notes),
                ],
              ),
            ),
          ),
          Positioned(
            top: 9,
            right: 16,
            child: Icon(
              Icons.swipe_left,
              size: 20,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
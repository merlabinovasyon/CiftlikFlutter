import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'AnimalGroupController.dart';

class AnimalGroupCard extends StatelessWidget {
  final String group;
  final AnimalGroupController controller = Get.find();

  AnimalGroupCard({Key? key, required this.group}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(group),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.17, // Kaydırma oranını biraz daha geniş tut
        children: [
          SlidableAction(
            onPressed: (context) {
              controller.removeGroup(group);  // Grubu silme işlevi
            },
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Sil',
            borderRadius: BorderRadius.circular(15.0),
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
            margin: const EdgeInsets.only(bottom: 10.0, right: 10, left: 10),
            child: ListTile(
              leading: Icon(Icons.group),  // Grup ikonu
              title: Text(
                'Grup Adı: ${group.isNotEmpty ? group : 'Bilinmiyor'}',
                style: TextStyle(fontWeight: FontWeight.bold),
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

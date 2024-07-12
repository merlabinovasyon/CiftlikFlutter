import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'SutOlcumController.dart';

class SutOlcumCard extends StatelessWidget {
  final Map<String, dynamic> sutOlcum;
  final String tableName;

  const SutOlcumCard({Key? key, required this.sutOlcum, required this.tableName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SutOlcumController controller = Get.find();

    return Slidable(
      key: ValueKey(sutOlcum['id']),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.17,
        children: [
          SlidableAction(
            onPressed: (context) {
              controller.removeSutOlcum(sutOlcum['id'], tableName);
              Get.snackbar('Başarılı', 'Süt ölçüm bilgisi silindi');
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
            elevation: 4.0,
            shadowColor: Colors.cyan,
            margin: const EdgeInsets.only(bottom: 10.0, right: 5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Image.asset(
                      'icons/milk_bucket_icon_black.png',
                      width: 55,
                      height: 55,
                    ),
                  ),
                  const SizedBox(width: 16.0),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Küpe No: ${sutOlcum['type']}',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 4.0),
                        Text('Ağırlık: ${sutOlcum['weight']} kg'),
                        const SizedBox(height: 4.0),
                        Text('Tarih: ${sutOlcum['date']}'),
                        const SizedBox(height: 4.0),
                        Text('Saat: ${sutOlcum['time']}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 10,
            right: 20,
            child: Icon(
              Icons.swipe_left,
              size: 18,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}

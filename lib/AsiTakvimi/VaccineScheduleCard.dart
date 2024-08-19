import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';

class VaccineScheduleCard extends StatelessWidget {
  final int id;
  final String event;
  final String date;
  final String time;
  final Function(int) onDelete;

  VaccineScheduleCard({Key? key, required this.id, required this.event, required this.date, required this.time, required this.onDelete}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: ValueKey(event),
      endActionPane: ActionPane(
        motion: ScrollMotion(),
        extentRatio: 0.17,
        children: [
          SlidableAction(
            onPressed: (context) {
              onDelete(id);
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
              leading: Icon(Icons.medical_services),
              title: Text('$date, $time'),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(event.split(', Notes: ')[0]), // Vaccine kısmını göster
                  Text(event.split(', Notes: ')[1]), // Notes kısmını göster
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

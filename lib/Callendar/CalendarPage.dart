import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Drawer/drawer_menu.dart';
import 'CalendarController.dart';


class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final CalendarController calendarController = Get.put(CalendarController());

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        elevation: 4,
        shadowColor: Colors.black38,
        title: Row(
          children: [
            SizedBox(width: 90),
            Text("Ajanda"),
          ],
        ),
      ),
      drawer: DrawerMenu(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: calendarController.animalTypeController,
              decoration: InputDecoration(labelText: 'Hayvan Türü'),
            ),
            SizedBox(height: 20),
            TextField(
              controller: calendarController.typeDescController,
              decoration: InputDecoration(labelText: 'Tür Açıklaması'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                String animalType = calendarController.animalTypeController.text;
                String typeDesc = calendarController.typeDescController.text;
                calendarController.insertAnimal(animalType, typeDesc);
              },
              child: Text('Kaydet'),
            ),
          ],
        ),
      ),
    );
  }
}

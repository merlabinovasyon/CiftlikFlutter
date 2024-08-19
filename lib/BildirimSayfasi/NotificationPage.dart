import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'NotificationController.dart';

class NotificationPage extends StatelessWidget {
  final NotificationController controller = Get.put(NotificationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notification Page'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              onChanged: (value) {
                controller.firstTextField.value = value;
              },
              decoration: InputDecoration(
                labelText: 'Birinci Alan',
              ),
            ),
            SizedBox(height: 16.0),
            TextField(
              onChanged: (value) {
                controller.secondTextField.value = value;
              },
              decoration: InputDecoration(
                labelText: 'İkinci Alan',
              ),
            ),
            SizedBox(height: 16.0),
            Obx(() {
              return Text('Seçilen Tarih ve Saat: ${controller.selectedDateTime.value}');
            }),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (_) => Container(
                    height: 250,
                    color: Color.fromARGB(255, 255, 255, 255),
                    child: Column(
                      children: [
                        Container(
                          height: 180,
                          child: CupertinoDatePicker(
                            initialDateTime: controller.selectedDateTime.value,
                            onDateTimeChanged: (DateTime newDateTime) {
                              controller.selectedDateTime.value = newDateTime;
                            },
                            use24hFormat: true,
                            mode: CupertinoDatePickerMode.dateAndTime,
                          ),
                        ),
                        CupertinoButton(
                          child: Text('Tamam'),
                          onPressed: () => Navigator.of(context).pop(),
                        )
                      ],
                    ),
                  ),
                );
              },
              child: Text('Tarih ve Saat Seç'),
            ),
            SizedBox(height: 16.0),
            Obx(() {
              return Column(
                children: [
                  Text('Bildirim Sayısı: ${controller.numberOfNotifications.value}'),
                  Slider(
                    value: controller.numberOfNotifications.value.toDouble(),
                    min: 1,
                    max: 10,
                    divisions: 9,
                    onChanged: (value) {
                      controller.numberOfNotifications.value = value.toInt();
                    },
                  ),
                ],
              );
            }),
            SizedBox(height: 32.0),
            ElevatedButton(
              onPressed: () {
                controller.scheduleMultipleNotifications();
              },
              child: Text('Bildirimleri Planla'),
            ),
          ],
        ),
      ),
    );
  }
}

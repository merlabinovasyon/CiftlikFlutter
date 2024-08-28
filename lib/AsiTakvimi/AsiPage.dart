import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../FormFields/FormButton.dart';
import 'AsiController.dart';
import 'TableCalendarWidget.dart';
import 'VaccineScheduleCard.dart';
import 'BuildSelectionVaccineScheduleField.dart';
import 'BuildTimeScheduleField.dart';

class AsiPage extends StatelessWidget {
  final AsiController controller = Get.put(AsiController());
  final FocusNode searchFocusNode = FocusNode();

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
          child: Padding(
            padding: const EdgeInsets.only(right: 60.0),
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
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TableCalendarWidget(controller: controller),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: TextField(
              focusNode: searchFocusNode,
              cursorColor: Colors.black54,
              controller: controller.notesController,
              decoration: InputDecoration(
                labelText: 'Not Ekle',
                labelStyle: TextStyle(color: Colors.black),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.0),
                  borderSide: BorderSide(color: Colors.black),
                ),
              ),
              onTapOutside: (event) {
                searchFocusNode.unfocus(); // Dışarı tıklanırsa klavyeyi kapat ve imleci gizle
              },
            ),
          ),
          const SizedBox(height: 16),
          BuildTimeScheduleField(
            label: 'Tarih ve Saat Seç',
            controller: controller.timeController,
            selectedDateTime: controller.selectedDateTime,
          ),
          const SizedBox(height: 16),
          Obx(() {
            return BuildSelectionVaccineScheduleField(
              label: 'Aşı Tipi *',
              value: controller.vaccineType,
              options: controller.vaccines.map((vaccine) => vaccine['vaccineName'] as String).toList(),
              onSelected: (value) {
                controller.vaccineType.value = value;
              },
            );
          }),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0, right: 8, left: 8),
            child: FormButton(
              title: 'Ekle',
              onPressed: () {
                if (controller.notesController.text.isNotEmpty && controller.vaccineType.value != null) {
                  controller.addEvent();
                  Get.snackbar(
                    'Başarılı',
                    'Ekleme başarılı',
                  );
                } else {
                  Get.snackbar(
                    'Hata',
                    'Lütfen tüm alanları doldurun ve bir aşı tipi seçin',
                  );
                }
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Obx(() {
            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: controller
                  .getEventsForDay(controller.selectedDay.value)
                  .map((eventMap) => VaccineScheduleCard(
                id: eventMap['id'],
                event: eventMap['event'],
                date: eventMap['date'],
                time: eventMap['time'],
                onDelete: (id) {
                  controller.deleteEvent(id);
                },
              ))
                  .toList(),
            );
          }),
        ],
      ),
    );
  }
}

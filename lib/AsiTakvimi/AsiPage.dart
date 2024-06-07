import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:merlabciftlikyonetim/AsiTakvimi/AsiController.dart';
import 'package:table_calendar/table_calendar.dart';

import '../FormFields/FormButton.dart';

class AsiPage extends StatelessWidget {
  final AsiController controller = Get.put(AsiController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
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
          Obx(() {
            return Container(
              decoration: BoxDecoration(
                color: Colors.black, // Takvim arka planını siyah yapar
                borderRadius: BorderRadius.circular(16.0), // Kenarları yumuşatır
                border: Border.all(color: Colors.white), // Sınır çizgisi ekler
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyan.withOpacity(0.5), // Gölge rengi
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 4), // Gölgenin pozisyonu
                  ),
                ],
              ),
              child: TableCalendar(
                locale: 'tr_TR',
                focusedDay: controller.selectedDay.value,
                firstDay: DateTime(2000),
                lastDay: DateTime(2100),
                calendarFormat: CalendarFormat.month,
                selectedDayPredicate: (day) => isSameDay(controller.selectedDay.value, day),
                onDaySelected: (selectedDay, focusedDay) {
                  controller.selectedDay.value = selectedDay;
                },
                onPageChanged: (focusedDay) {
                  controller.selectedDay.value = focusedDay;
                },
                eventLoader: controller.getEventsForDay,
                calendarStyle: CalendarStyle(
                  todayDecoration: BoxDecoration(
                    color: Colors.white54,
                    shape: BoxShape.circle,
                  ),
                  selectedDecoration: BoxDecoration(
                    color: Colors.cyan.withOpacity(0.5),
                    shape: BoxShape.circle,
                  ),
                  todayTextStyle: TextStyle(color: Colors.white),
                  defaultTextStyle: TextStyle(color: Colors.white),
                  weekendTextStyle: TextStyle(color: Colors.white),
                  outsideTextStyle: TextStyle(color: Colors.grey),
                  cellMargin: EdgeInsets.all(2.0), // Hücreler arasındaki boşluk
                  markerDecoration: BoxDecoration(
                    color: Colors.white, // Günün altında çıkan noktanın rengi
                    shape: BoxShape.circle,
                  ),
                ),
                daysOfWeekStyle: DaysOfWeekStyle(
                  weekdayStyle: TextStyle(color: Colors.white),
                  weekendStyle: TextStyle(color: Colors.white),
                ),
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronIcon: Icon(Icons.chevron_left, color: Colors.white),
                  rightChevronIcon: Icon(Icons.chevron_right, color: Colors.white),
                ),
                calendarBuilders: CalendarBuilders(
                  headerTitleBuilder: (context, day) {
                    return InkWell(
                      onTap: () async {
                        DateTime? pickedDate = await showDatePicker(
                          context: context,
                          initialDate: controller.selectedDay.value,
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                          locale: const Locale('tr', 'TR'),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.dark().copyWith(
                                colorScheme: ColorScheme.dark(
                                  primary: Colors.cyan.withOpacity(0.5),
                                  onPrimary: Colors.white,
                                  surface: Colors.black,
                                  onSurface: Colors.white,
                                ),
                                dialogBackgroundColor: Colors.blueGrey[800],
                              ),
                              child: child!,
                            );
                          },
                        );
                        if (pickedDate != null && pickedDate != controller.selectedDay.value) {
                          controller.selectedDay.value = pickedDate;
                        }
                      },
                      child: Center(
                        child: Text(
                          DateFormat('d MMMM y', 'tr').format(controller.selectedDay.value),
                          style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.white),
                        ),
                      ),
                    );
                  },
                ),
              ),
            );
          }),
          const SizedBox(height: 8.0),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: controller.eventController,
              decoration: const InputDecoration(
                labelText: 'Not Ekle',
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0,right: 8,left: 8),
            child: FormButton(
              title: 'Ekle',
              onPressed: () {
                if (controller.eventController.text.isNotEmpty) {
                  controller.addEvent(controller.eventController.text);
                  Get.snackbar(
                    'Başarılı',
                    'Ekleme başarılı',
                  );
                  Future.delayed(const Duration(seconds: 1), () {
                  });
                }
              },
            ),
          ),
          const SizedBox(height: 8.0),
          Obx(() {
            return ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(), // İç içe kaydırmayı önler
              children: controller
                  .getEventsForDay(controller.selectedDay.value)
                  .map((event) => ListTile(
                title: Text(event),
              ))
                  .toList(),
            );
          }),
        ],
      ),
    );
  }
}

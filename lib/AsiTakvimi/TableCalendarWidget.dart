import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';
import 'AsiController.dart';

class TableCalendarWidget extends StatelessWidget {
  final AsiController controller;

  TableCalendarWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
          border: Border.all(color: Colors.white),
          boxShadow: [
            BoxShadow(
              color: Colors.grey,
              spreadRadius: 2,
              blurRadius: 5,
              offset: Offset(0, 4),
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
            todayTextStyle: TextStyle(color: Colors.black),
            defaultTextStyle: TextStyle(color: Colors.black),
            weekendTextStyle: TextStyle(color: Colors.black),
            outsideTextStyle: TextStyle(color: Colors.grey),
            cellMargin: EdgeInsets.all(2.0),
            markerDecoration: BoxDecoration(
              color: Colors.black,
              shape: BoxShape.circle,
            ),
          ),
          daysOfWeekStyle: DaysOfWeekStyle(
            weekdayStyle: TextStyle(color: Colors.black),
            weekendStyle: TextStyle(color: Colors.black),
          ),
          headerStyle: HeaderStyle(
            formatButtonVisible: false,
            titleCentered: true,
            leftChevronIcon: Icon(Icons.chevron_left, color: Colors.black),
            rightChevronIcon: Icon(Icons.chevron_right, color: Colors.black),
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
                    style: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black87),
                  ),
                ),
              );
            },
          ),
        ),
      );
    });
  }
}

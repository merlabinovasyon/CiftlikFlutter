import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AsiController extends GetxController {
  Rx<DateTime> selectedDay = DateTime.now().obs;
  RxMap<DateTime, List<String>> events = <DateTime, List<String>>{}.obs;
  TextEditingController eventController = TextEditingController();

  void addEvent(String event) {
    if (events[selectedDay.value] != null) {
      events[selectedDay.value]?.add(event);
    } else {
      events[selectedDay.value] = [event];
    }
    eventController.clear();
  }

  List<String> getEventsForDay(DateTime day) {
    return events[day] ?? [];
  }
}

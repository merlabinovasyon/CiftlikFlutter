import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:merlabciftlikyonetim/AsiTakvimi/DatabaseScheduleHelper.dart';
import 'package:merlabciftlikyonetim/AnimalService/AnimalService.dart';
import 'package:timezone/timezone.dart' as tz;

class AsiController extends GetxController {
  Rx<DateTime> selectedDay = DateTime.now().obs;
  Rx<DateTime?> selectedDateTime = Rx<DateTime?>(null);
  RxMap<DateTime, List<Map<String, dynamic>>> events = <DateTime, List<Map<String, dynamic>>>{}.obs;
  TextEditingController notesController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  var vaccineType = Rxn<String>();
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  var vaccines = <Map<String, dynamic>>[].obs;

  @override
  void onInit() {
    super.onInit();
    _loadEvents().then((_) {
      loadSelectedDayEvents();  // Ensure that events for the selected day are loaded
    });
    _loadVaccines();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  Future<void> addEvent() async {
    if (vaccineType.value == null) {
      Get.snackbar('Hata', 'Lütfen bir aşı tipi seçin');
      return;
    }

    final event = 'Vaccine: ${vaccineType.value}, Notes: ${notesController.text}';
    DateTime eventDate = selectedDateTime.value ?? DateTime.now();

    Map<String, dynamic> newEvent = {
      'event': event,
      'date': DateFormat('d MMMM y', 'tr').format(eventDate),
      'time': DateFormat('HH:mm', 'tr').format(eventDate),
    };

    try {
      int eventId = await DatabaseScheduleHelper().insertEvent(
        eventDate,
        DateFormat('HH:mm').format(selectedDateTime.value ?? DateTime.now()),
        notesController.text,
        vaccineType.value!,
      );
      newEvent['id'] = eventId;
      scheduleNotification(eventId);
    } catch (e) {
      print("Error adding event: $e");
    }

    if (events[eventDate] != null) {
      events[eventDate]?.add(newEvent);
    } else {
      events[eventDate] = [newEvent];
    }

    // Clear fields
    notesController.clear();
    vaccineType.value = null;
    selectedDateTime.value = null; // selectedDateTime'ı null yap
    timeController.clear(); // TextFormField içeriğini boşalt
    await _loadEvents(); // Yeniden yükle
    loadSelectedDayEvents(); // Reload events for the selected day
  }

  void scheduleNotification(int eventId) async {
    final tz.TZDateTime scheduledDate = tz.TZDateTime.from(selectedDateTime.value ?? DateTime.now(), tz.local);
    const AndroidNotificationDetails androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'your_channel_id',
      'your_channel_name',
      channelDescription: 'your_channel_description',
      importance: Importance.max,
      priority: Priority.high,
      showWhen: false,
    );
    const NotificationDetails platformChannelSpecifics = NotificationDetails(android: androidPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.zonedSchedule(
      eventId, // Use eventId as unique id
      'Aşı Takvimi Hatırlatması',
      'Aşı Tipi: ${vaccineType.value}, Notlar: ${notesController.text}',
      scheduledDate,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.dateAndTime,
      payload: 'item x',
    );
  }

  Future<void> _loadEvents() async {
    List<Map<String, dynamic>> eventsFromDb = await DatabaseScheduleHelper().getEvents();
    events.clear();
    eventsFromDb.forEach((event) {
      DateTime date = DateTime.parse(event['date']);
      String eventName = 'Aşı Tipi: ${event['vaccine']}, Notes: ${event['notes']}';
      String eventTime = event['time'];
      if (events[date] != null) {
        events[date]?.add({
          'id': event['id'],
          'event': eventName,
          'date': DateFormat('d MMMM y', 'tr').format(date),
          'time': eventTime,
        });
      } else {
        events[date] = [{
          'id': event['id'],
          'event': eventName,
          'date': DateFormat('d MMMM y', 'tr').format(date),
          'time': eventTime,
        }];
      }
    });
    loadSelectedDayEvents();  // Ensure that events for the selected day are loaded
  }

  Future<void> _loadVaccines() async {
    vaccines.assignAll(await AnimalService.instance.getVaccineList());
  }

  List<Map<String, dynamic>> getEventsForDay(DateTime day) {
    return events[day]?.map((event) => {
      'id': event['id'],
      'date': event['date']!,
      'time': event['time']!,
      'event': event['event']!,
    }).toList() ?? [];
  }

  void loadSelectedDayEvents() {
    selectedDay.refresh(); // Trigger UI update by refreshing the observable
  }

  void deleteEvent(int id) async {
    try {
      await DatabaseScheduleHelper().deleteEvent(id);
      await _loadEvents();
      loadSelectedDayEvents(); // Reload events for the selected day
      Get.snackbar('Başarılı', 'Silme başarılı');
    } catch (e) {
      print("Error deleting event: $e");
      Get.snackbar('Hata', 'Silme işlemi başarısız');
    }
  }
}

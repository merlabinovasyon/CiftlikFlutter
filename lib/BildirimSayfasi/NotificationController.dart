import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationController extends GetxController {
  var firstTextField = ''.obs;
  var secondTextField = ''.obs;
  var selectedDateTime = DateTime.now().obs;
  var numberOfNotifications = 1.obs;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void onInit() {
    super.onInit();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid = AndroidInitializationSettings('@mipmap/ic_launcher');
    final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );
    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  void scheduleMultipleNotifications() async {
    for (int i = 0; i < numberOfNotifications.value; i++) {
      final tz.TZDateTime scheduledDate = tz.TZDateTime.from(selectedDateTime.value.add(Duration(seconds: i * 2)), tz.local);
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
        i,
        'Bildirim $i',
        'Birinci Alan: ${firstTextField.value}, İkinci Alan: ${secondTextField.value}',
        scheduledDate,
        platformChannelSpecifics,
        androidAllowWhileIdle: true,
        uiLocalNotificationDateInterpretation: UILocalNotificationDateInterpretation.absoluteTime,
        matchDateTimeComponents: DateTimeComponents.time,
        payload: 'item $i',
      );
    }
  }
}


import 'dart:async';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
class LocalNotificationService {
  static FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  /// initial notifications with android and ios
  static Future<void> init() async {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');
    final DarwinInitializationSettings initializationSettingsDarwin =
    DarwinInitializationSettings(
      onDidReceiveLocalNotification: (id, title, body, payload) {},
    );
    InitializationSettings settings = InitializationSettings(android: initializationSettingsAndroid , iOS: initializationSettingsDarwin);
    flutterLocalNotificationsPlugin.initialize(settings , onDidReceiveNotificationResponse: onTap);
    // request notification permissions
    flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<AndroidFlutterLocalNotificationsPlugin>()?.requestNotificationsPermission();
  }
  static StreamController<NotificationResponse>  streamController = StreamController();
  static void onTap(NotificationResponse notificationResponse){
    /// Navigator
    streamController.add(notificationResponse);
  }
/*
  static Future<void> showSimpleNotification () async {
    const AndroidNotificationDetails androidNotificationDetails =
    AndroidNotificationDetails(
        'channel 2',
        'your channel name',
        channelDescription: 'your channel description',
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker');
    const DarwinNotificationDetails  iosNotificationDetails=
     DarwinNotificationDetails(
      presentAlert: true,
       presentBadge:  true ,
       presentSound: true
    );
    const NotificationDetails notificationDetails = NotificationDetails(android: androidNotificationDetails , iOS:iosNotificationDetails );
    flutterLocalNotificationsPlugin.show(0, "title", "body", notificationDetails);
  }
*/
  static Future<void> showSimpleNotification({
    required String title,
    required String body,
    required String payload,
  }) async {
    const notificationDetails = NotificationDetails(
      android: AndroidNotificationDetails(
        'asroo-id',
        'asroo-name',
        importance: Importance.max,
        priority: Priority.high,
      ),
      iOS: DarwinNotificationDetails(
        presentAlert: true,
        presentBadge: true,
        presentSound: true,
      ),
    );
    await flutterLocalNotificationsPlugin.show(
      0,
      title,
      body,
      notificationDetails,
      payload: payload,
    );
  }
}

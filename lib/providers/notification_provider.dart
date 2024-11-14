import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/notification_model.dart';

class NotificationProvider with ChangeNotifier {
  List<NotificationModel> notifications = [];
  List<NotificationModel> filteredNotifications = [];

  List<NotificationModel> get getNotifications {
    return notifications;
  }

  SharedPreferences? sp;
  NotificationProvider() {
    getSharedPreferences();
  }
  Future<void> getSharedPreferences() async {
    sp = await SharedPreferences.getInstance();
    readNotificationsFromSharedPreferences();
  }

  void saveIntoSharedPreferences() {
    List<String> contactListString =
        notifications.map((contact) => jsonEncode(contact.toJson())).toList();
    sp?.setStringList('myData', contactListString);
  }

  void readNotificationsFromSharedPreferences() {
    List<String>? contactListString = sp?.getStringList('myData');
    if (contactListString != null) {
      notifications = contactListString
          .map((contact) => NotificationModel.fromJson(jsonDecode(contact)))
          .toList();
    }
    filteredNotifications = List.from(notifications);
    notifyListeners();
  }

  void addNotification(String title, String body, String id) {
    NotificationModel newNotification = NotificationModel(title: title, body: body, id: id, dateTime: DateTime.now());
    notifications.add(newNotification);
    filteredNotifications.add(newNotification);
    saveIntoSharedPreferences();
    notifyListeners();
  }
}

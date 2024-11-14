import 'package:dio/dio.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';

import 'firebase_messaging_navigate.dart';
import 'models/product_model.dart';

class FirebaseCloudMessaging {
  factory FirebaseCloudMessaging() => _instance;

  FirebaseCloudMessaging._();

  static final FirebaseCloudMessaging _instance = FirebaseCloudMessaging._();

  static const String subscribeKey = 'twins-shop';

  final _firebaseMessaging = FirebaseMessaging.instance;

  ValueNotifier<bool> isNotificationSubscribe = ValueNotifier(true);

  bool isPermissionNotification = false;

  Future<void> init() async {
    //permission
    await _permissionsNotification();


    FirebaseMessaging.onMessage
        .listen(FirebaseMessagingNavigate.forGroundHandler);

    // terminated
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then(FirebaseMessagingNavigate.terminatedHandler);

    // background
    FirebaseMessaging.onMessageOpenedApp
        .listen(FirebaseMessagingNavigate.backGroundHandler);
  }

  /// controller for the notification if user subscribe or unsubscribed
  /// or accpeted the permission or not

/*
  Future<void> controllerForUserSubscribe(BuildContext context) async {
    if (isPermissionNotification == false) {
      await _permissionsNotification();
    } else {
      if (isNotificationSubscribe.value == false) {
        await _subscribeNotification();
        if (!context.mounted) return;
        ShowToast.showToastSuccessTop(
          message: context.translate(LangKeys.subscribedToNotifications),
          seconds: 2,
        );
      } else {
        await _unSubscribeNotification();
        if (!context.mounted) return;
        ShowToast.showToastSuccessTop(
          message: context.translate(LangKeys.unsubscribedToNotifications),
          seconds: 2,
        );
      }
    }
  }
*/

  /// permissions to notifications
  Future<void> _permissionsNotification() async {
    final settings = await _firebaseMessaging.requestPermission(badge: false);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      /// subscribe to notifications topic
      isPermissionNotification = true;
      await _subscribeNotification();
      debugPrint('🔔🔔 User accepted the notification permission');
    } else {
      isPermissionNotification = false;
      isNotificationSubscribe.value = false;
      debugPrint('🔕🔕 User not accepted the notification permission');
    }
  }

  /// subscribe notification

  Future<void> _subscribeNotification() async {
    isNotificationSubscribe.value = true;
    await FirebaseMessaging.instance.subscribeToTopic(subscribeKey);
    debugPrint('====🔔 Notification Subscribed 🔔=====');
  }

  /// unsubscribe notification

  Future<void> _unSubscribeNotification() async {
    isNotificationSubscribe.value = false;
    await FirebaseMessaging.instance.unsubscribeFromTopic(subscribeKey);
    debugPrint('====🔕 Notification Unsubscribed 🔕=====');
  }

// send notifcation with api
  Future<void> sendTopicNotification({
    required String title,
    required String body,

  }) async {
    try {
      final response = await Dio().post<dynamic>(
        'https://fcm.googleapis.com/fcm/send',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAhnEbLrU:APA91bEdVN_KN3Hbh2fg5N-we8eYZ6euQOeh6FhvZc_OAtyQQ5N1tEtlIY6PezJM7Adi2FXSvifTiMAa70u0g0BWHg8_QgwcKsAbcN4zLwwpBPwCKh8iLdG1oWNwPkOOqAzeniFoCWJE',
          },
        ),
        data: {
          //'to': 'efZm9hXQT9mxtehteYjjL5:APA91bHnXK4HGNs_g7mohZBPi_rTbx6Vrqd_hR5MUQ_xC_fUML6jTqFioHcKm39hTZAiV11CraPVC4b4aveqoNtS5XWeQA8Z5tMRQAkMLPUD6hrhxQ2HdLHswy5saQ8fybH3F6YoyyHC',
          'to': '/topics/$subscribeKey',
          'notification': {
            'title': title,
            'body': body,
          },
          'data': {
            "productId": "d1dbeb65-68d1-4dd0-bb60-742e3a3412b1",
            "productTitle": "fares",
            "productPrice": "50",
            "productCategory": "Electronics",
            "productDescription": "Test ععه",
            "productImage": "",
            "productQuantity": "200",
            "createdAt": "2024-05-11T12:54:45.826177"
          },
        },
      );

      debugPrint('Notification Created => ${response.data}');
    } catch (e) {
      debugPrint('Notification Error => $e');
    }
  }

  Future<void> sendTopicNotificationAdmin({
    required String title,
    required String body,
    required String productId,
    required String productTitle,
    required String productPrice,
    required String productCategory,
    required String productDescription,
    required String productImage,
    required String productQuantity,
  }) async {
    try {
      final response = await Dio().post<dynamic>(
        'https://fcm.googleapis.com/fcm/send',
        options: Options(
          validateStatus: (_) => true,
          contentType: Headers.jsonContentType,
          responseType: ResponseType.json,
          headers: {
            'Content-Type': 'application/json',
            'Authorization':
                'key=AAAAhnEbLrU:APA91bEdVN_KN3Hbh2fg5N-we8eYZ6euQOeh6FhvZc_OAtyQQ5N1tEtlIY6PezJM7Adi2FXSvifTiMAa70u0g0BWHg8_QgwcKsAbcN4zLwwpBPwCKh8iLdG1oWNwPkOOqAzeniFoCWJE',
          },
        ),
        data: {
          //'to': 'efZm9hXQT9mxtehteYjjL5:APA91bHnXK4HGNs_g7mohZBPi_rTbx6Vrqd_hR5MUQ_xC_fUML6jTqFioHcKm39hTZAiV11CraPVC4b4aveqoNtS5XWeQA8Z5tMRQAkMLPUD6hrhxQ2HdLHswy5saQ8fybH3F6YoyyHC',
          'to': '/topics/$subscribeKey',
          'notification': {
            'title': title,
            'body': body,
          },
          'data': {
            "productId": productId,
            "productTitle": productTitle,
            "productPrice": productPrice,
            "productCategory": productCategory,
            "productDescription": productCategory,
            "productImage": productImage,
            "productQuantity": productQuantity,
            "createdAt": "2024-05-11T12:54:45.826177"
          },
        },
      );

      debugPrint('Notification Created => ${response.data}');
    } catch (e) {
      debugPrint('Notification Error => $e');
    }
  }
}

import 'package:admin/screens/inner_screens/orders/orders_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import '../models/product_model.dart';
import 'local_notification_service.dart';
import 'main.dart';

class FirebaseMessagingNavigate {
/*  static Future<void> forGroundHandler(RemoteMessage? message) async {
    if (message != null) {
      final productModel = ProductModel(
        productId: message.data['productId'].toString(),
        productTitle: message.notification?.title ?? '',
        productPrice: message.data['productPrice'] ?? '',
        productCategory: message.data['productCategory'] ?? '',
        productDescription: message.data['productDescription'] ?? '',
        productImage: message.data['productImage'] ?? '',
        productQuantity: message.data['productQuantity'] ?? '',
      );
      await LocalNotificationService.showSimpleNotification(
        title: productModel.productTitle,
        body: productModel.productDescription,
        payload: productModel.productId,
      );
      _navigate(message, productModel);
    }
  }
  static void backGroundHandler(RemoteMessage? message) {
    if (message != null) {
      final productModel = ProductModel(
        productId: message.data['productId'].toString(),
        productTitle: message.notification?.title ?? '',
        productPrice: message.data['productPrice'] ?? '',
        productCategory: message.data['productCategory'] ?? '',
        productDescription: message.data['productDescription'] ?? '',
        productImage: message.data['productImage'] ?? '',
        productQuantity: message.data['productQuantity'] ?? '',
      );
      _navigate(message, productModel);
    }
  }
  static void terminatedHandler(RemoteMessage? message) {
    if (message != null) {
      final productModel = ProductModel(
        productId: message.data['productId'].toString(),
        productTitle: message.notification?.title ?? '',
        productPrice: message.data['productPrice'] ?? '',
        productCategory: message.data['productCategory'] ?? '',
        productDescription: message.data['productDescription'] ?? '',
        productImage: message.data['productImage'] ?? '',
        productQuantity: message.data['productQuantity'] ?? '',
      );
      _navigate(message, productModel);
    }
  }
  static void _navigate(RemoteMessage? message, ProductModel? productModel) {
    if (productModel != null) {
      navigatorKey.currentState?.pushNamed(
        ProductDetails.routName,
        arguments: productModel,
      );
    }
  }*/
  static Future<void> forGroundHandler(RemoteMessage? message) async {
    if (message != null) {
      final productModel = ProductModel(
        productId: message.data['productId'].toString(),
        productTitle: message.notification?.title ?? '',
        productPrice: message.data['productPrice'] ?? '',
        productCategory: message.data['productCategory'] ?? '',
        productDescription: message.data['productDescription'] ?? '',
        productImage: message.data['productImage'] ?? '',
        productQuantity: message.data['productQuantity'] ?? '',
      );
      await LocalNotificationService.showSimpleNotification(
        title: productModel.productTitle,
        body: productModel.productDescription,
        payload: productModel.productId,
      );
      _navigate(message, productModel);
    }
  }
  static void backGroundHandler(RemoteMessage? message) {
    if (message != null) {
      final productModel = ProductModel(
        productId: message.data['productId'].toString(),
        productTitle: message.notification?.title ?? '',
        productPrice: message.data['productPrice'] ?? '',
        productCategory: message.data['productCategory'] ?? '',
        productDescription: message.data['productDescription'] ?? '',
        productImage: message.data['productImage'] ?? '',
        productQuantity: message.data['productQuantity'] ?? '',
      );
      _navigate(message, productModel);
    }
  }
  static void terminatedHandler(RemoteMessage? message) {
    if (message != null) {
      final productModel = ProductModel(
        productId: message.data['productId'].toString(),
        productTitle: message.notification?.title ?? '',
        productPrice: message.data['productPrice'] ?? '',
        productCategory: message.data['productCategory'] ?? '',
        productDescription: message.data['productDescription'] ?? '',
        productImage: message.data['productImage'] ?? '',
        productQuantity: message.data['productQuantity'] ?? '',
      );
      _navigate(message, productModel);
    }
  }
  static void _navigate(RemoteMessage? message, ProductModel? productModel) {
    if (productModel != null) {
      navigatorKey.currentState?.pushNamed(
        OrdersScreenFree.routeName,
        arguments: productModel,
      );
    }
  }
  static Future<void> init(BuildContext context) async {
    FirebaseMessaging.onMessage.listen(forGroundHandler);
    await FirebaseMessaging.instance
        .getInitialMessage()
        .then(terminatedHandler);

    FirebaseMessaging.onMessageOpenedApp.listen(backGroundHandler);
  }

}

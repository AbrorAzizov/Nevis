import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseManager {
  Future<bool> requestPushPermission(BuildContext context) async {
    // 1. Запрос у Firebase Messaging (обязательно для iOS)
    final settings = await FirebaseMessaging.instance.requestPermission();

    // 2. Проверяем статус через permission_handler
    final status = await Permission.notification.status;

    if (status.isDenied) {
      await Permission.notification.request();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    // 3. Возвращаем true, если разрешение получено
    return (await Permission.notification.status).isGranted &&
        settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}

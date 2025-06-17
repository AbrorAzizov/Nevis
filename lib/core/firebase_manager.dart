import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class FirebaseManager {
  Future<bool> requestPushPermission(BuildContext context) async {
    /*final firebaseSettings =
        await FirebaseMessaging.instance.requestPermission();

    if (firebaseSettings.authorizationStatus == AuthorizationStatus.denied) {
      final isPermanentlyDenied =
          await Permission.notification.isPermanentlyDenied;

      if (isPermanentlyDenied) {
        await openAppSettings();
      } else {
        await Permission.notification.request();
      }
    }*/
    final status = await Permission.notification.status;

    if (status.isDenied) {
      await Permission.notification.request();
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }

    return (await Permission.notification.status).isGranted;
  }
}

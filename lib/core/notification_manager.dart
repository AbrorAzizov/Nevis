import 'dart:async';
import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationManager {
  static final FlutterLocalNotificationsPlugin
      _flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  static late AndroidNotificationChannel channel;
  static bool isFlutterLocalNotificationsInitialized = false;

  static StreamSubscription<RemoteMessage>? _messageSubscription;

  static Future<void> initNotifications(
      {Function(String?)? handleNotificationClick}) async {
    if (isFlutterLocalNotificationsInitialized) return;

    channel = const AndroidNotificationChannel(
      'high_importance_channel', // id
      'High Importance Notifications', // title
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
    );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);

    isFlutterLocalNotificationsInitialized = true;

    await _flutterLocalNotificationsPlugin.initialize(
      const InitializationSettings(
        android: AndroidInitializationSettings('android12splash'),
        iOS: DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
        ),
      ),
      onDidReceiveNotificationResponse: (NotificationResponse response) {
        handleNotificationClick?.call(response.payload);
      },
    );
  }

  static Future<void> connectToForegroundMessages(
      {Function(String?)? handleNotificationClick}) async {
    _messageSubscription ??=
        FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Foreground message received: ${message.messageId}');
      showFlutterNotification(message);
    });

    // Handle notification click when app is in background
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      handleNotificationClick?.call(json.encode(message.data));
    });
  }

  static Future<void> disconnectFromForegroundMessages() async {
    await _messageSubscription?.cancel();
    _messageSubscription = null;
  }

  static Future<void> showFlutterNotification(
      RemoteMessage remoteMessage) async {
    const androidDetails = AndroidNotificationDetails(
        'high_importance_channel', 'High Importance Notifications',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        enableVibration: true,
        icon: 'android12splash',
        ongoing: true,
        setAsGroupSummary: true);

    const iOSDetails = DarwinNotificationDetails(
      presentSound: true,
      presentAlert: true,
      presentBadge: true,
      presentBanner: true,
    );

    const platformDetails = NotificationDetails(
      android: androidDetails,
      iOS: iOSDetails,
    );

    await _flutterLocalNotificationsPlugin.show(
      remoteMessage.hashCode,
      remoteMessage.data['title'] ?? remoteMessage.notification?.title ?? '',
      remoteMessage.data['body'] ?? remoteMessage.notification?.body ?? '',
      platformDetails,
      payload: json.encode(remoteMessage.data),
    );
  }
}

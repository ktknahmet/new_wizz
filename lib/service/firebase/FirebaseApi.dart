import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:wizzsales/utils/function/SharedPref.dart';
import 'package:wizzsales/utils/notification/NotificationUtils.dart';
import 'package:wizzsales/utils/res/SharedUtils.dart';
@pragma('vm:entry-point')
class FirebaseApi {

  SharedPref pref = SharedPref();
  final firebaseMessaging = FirebaseMessaging.instance;

  Future<void> initNotification() async {
    await firebaseMessaging.requestPermission();

    await firebaseMessaging.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    final fcmToken = await firebaseMessaging.getToken();
    await pref.setString(SharedUtils.firebaseToken, fcmToken!);
    print("firebaseToken:$fcmToken");

    FirebaseMessaging.onBackgroundMessage((message) async {
      print("bildirim veriler onBackgroundMessage :${message.data.entries} -- ${message.data.keys}");
      if (message.notification != null && message.notification!.title != null && message.notification!.body != null) {
        NotificationUtil().showNotification(title: message.notification!.title!, body: message.notification!.body!);
      } else {
        print("Bildirim verisi eksik veya beklenenden farklı");
      }
    });

      FirebaseMessaging.onMessage.listen((RemoteMessage event) {
        print("bildirim veriler on message :${event.data.entries} -- ${event.data.keys}");
        NotificationUtil().showNotification(title: event.notification!.title!, body: event.notification!.body!);
      });

    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("bildirim veriler on message :${event.data.entries} -- ${event.data.keys}");
      NotificationUtil().showNotification(title: event.notification!.title!, body: event.notification!.body!);
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage event) {
      print("bildirim veriler :${event.data.entries} -- ${event.data.keys}");
      /*if (event.data.containsKey("on_click")) {
        launchUrl(Uri.parse(event.data["on_click"]));
      }*/
    });

  }
}
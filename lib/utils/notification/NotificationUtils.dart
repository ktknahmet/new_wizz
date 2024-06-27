  import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

  class NotificationUtil{
    FlutterLocalNotificationsPlugin notificationsPlugin = FlutterLocalNotificationsPlugin();


    Future<void> initNotification(BuildContext context) async{
      AndroidInitializationSettings initializationSettingsAndroid =
      const AndroidInitializationSettings('flutter_logo');

      var initializationSettingsIos = DarwinInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification:
              (int id,String? title,String? body,String? payload) async {
          }
      );

      var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid,iOS: initializationSettingsIos,);


      await notificationsPlugin.initialize(initializationSettings,
          onDidReceiveNotificationResponse: (details) async {
             print("veriler :${details.id !} -- ${details.actionId!} -- ${details.payload!}");
             if(details.id==0){
             }
          });

    }
    Future showNotification({int id=0,String? title,String? body,String? payload}) async{
      return notificationsPlugin.show(id, title, body,await notificationDetails());
    }

    notificationDetails(){
      return const NotificationDetails(
        android: AndroidNotificationDetails(
            'channelId',
            'channelName',
            priority: Priority.high,
            icon: 'app',
            channelShowBadge: true,
            importance: Importance.max),
        iOS: DarwinNotificationDetails(
          presentAlert: true,
          presentBadge: true,
          presentBanner: true,
          presentSound: true,
        ),
      );

    }
  }
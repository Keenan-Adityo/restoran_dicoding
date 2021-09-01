import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:restoran_dicoding/data/model/restaurantlist.dart';
import 'package:rxdart/rxdart.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final selectNotificationSubject = BehaviorSubject<String>();

class NotificationHelper {
  static const _channelId = "01";
  static const _channelName = "channel_01";
  static const _channelDesc = "dicoding channel";
  static NotificationHelper? _instance;

  NotificationHelper._internal() {
    _instance = this;
  }

  factory NotificationHelper() => _instance ?? NotificationHelper._internal();

  Future<void> initNotifications(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');

    var initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid,
    );

    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
      print('notification payload: ' + payload!);
      selectNotificationSubject.add(payload);
    });
  }

  Future<void> showNotification(
      FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
      List<RestaurantList>? listRestaurants) async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDesc,
        importance: Importance.max, priority: Priority.high, ticker: 'ticker');

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    listRestaurants = listRestaurants?..shuffle();
    RestaurantList? restaurant =
        listRestaurants == null ? null : listRestaurants[0];
    var titleResto = restaurant?.name;

    await flutterLocalNotificationsPlugin.show(
      Random().nextInt(10),
      'Salah satu rekomendasi restoran kami',
      titleResto,
      platformChannelSpecifics,
      payload: jsonEncode(restaurant?.toJson()),
    );
  }

  void configureSelectNotificationSubject(BuildContext context, String route) {
    selectNotificationSubject.stream.listen((String? payload) {
      Navigator.pushReplacementNamed(context, '/restaurantView');
    });
  }
}

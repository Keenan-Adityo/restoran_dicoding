import 'dart:ui';
import 'dart:isolate';

import 'package:restoran_dicoding/data/api/api_service.dart';
import 'package:restoran_dicoding/main.dart';
import 'package:restoran_dicoding/utils/notification_helper.dart';
import 'package:http/http.dart' as http;

final ReceivePort port = ReceivePort();

class BackgroundService {
  static BackgroundService? _instance;
  static SendPort? _uiSendPort;
  static String _isolateName = 'isolate';

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(port.sendPort, _isolateName);
  }

  static Future<void> callback() async {
    final NotificationHelper _notificationHelper = NotificationHelper();
    final apiService = ApiService();
    var result = await apiService.getListRestaurant(http.Client());
    await _notificationHelper.showNotification(
      flutterLocalNotificationsPlugin,
      result.restaurants,
    );

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}

import 'package:restaurant_app/utils/notification_helper.dart';
import 'dart:ui';
import 'dart:isolate';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/main.dart';

final ReceivePort port = ReceivePort();
 
class BackgroundService {
  static BackgroundService _service;
  static String _isolateName = 'isolate';
  static SendPort _uiSendPort;
 
  BackgroundService._createObject();
 
  factory BackgroundService() {
    if (_service == null) {
      _service = BackgroundService._createObject();
    }
    return _service;
  }
 
  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }
 
  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper _notificationHelper = NotificationHelper();
    var result = await ApiService().getList();
    await _notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);
 
    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
 
  Future<void> someTask() async {
    print('Execute some process');
  }
}
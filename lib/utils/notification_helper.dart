import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:rxdart/rxdart.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'dart:convert';
import 'dart:math';

final selectNotificationSubject = BehaviorSubject<String>();
 
class NotificationHelper {
  static NotificationHelper _instance;
 
  NotificationHelper._internal() {
    _instance = this;
  }

  List shuffle(List items) {
  var random = new Random();
  for (var i = items.length - 1; i > 0; i--) {
    var n = random.nextInt(i + 1);
    var temp = items[i];
    items[i] = items[n];
    items[n] = temp;
  }

  return items;
}
 
  factory NotificationHelper() => _instance ?? NotificationHelper._internal();
 
  Future<void> initNotifications(
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin) async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
 
    var initializationSettingsIOS = IOSInitializationSettings(
      requestAlertPermission: false,
      requestBadgePermission: false,
      requestSoundPermission: false,
    );
 
    var initializationSettings = InitializationSettings(
       android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
 
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
       onSelectNotification: (String payload) async {
      if (payload != null) {
        print('notification payload: ' + payload);
      }
      selectNotificationSubject.add(payload ?? 'empty payload');
    });
  }
 
  Future<void> showNotification(
     FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
     ListRestaurant restaurant) async {
    var _channelId = "1";
    var _channelName = "channel_01";
    var _channelDescription = "dicoding news channel"; 
    List<RestaurantList> restaurants = shuffle(restaurant.restaurants);
 
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        _channelId, _channelName, _channelDescription,
        importance: Importance.max,
        priority: Priority.high,
        ticker: 'ticker',
        styleInformation: DefaultStyleInformation(true, true));
 
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics, iOS: iOSPlatformChannelSpecifics);
 
    var titleNotification = "<b>Lookup our fancy restaurant</b>";
    var titleRestauant = restaurants[0].name;
 
    await flutterLocalNotificationsPlugin.show(
        0, titleNotification, titleRestauant, platformChannelSpecifics,
        payload: json.encode(restaurants[0].toJson()));
  }
 
  void configureSelectNotificationSubject(String route) {
    selectNotificationSubject.stream.listen(
      (String payload) async {
        var data = RestaurantList.fromJson(json.decode(payload));
        Navigation.intentWithData(route, data);
      },
    );
  }
}
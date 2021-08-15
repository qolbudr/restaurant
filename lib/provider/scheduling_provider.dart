import 'package:flutter/material.dart';
import 'dart:async';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/utils/datetime_helper.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  SchedulingProvider() {
    checkLastConfig();
    
  }
 
  bool get isScheduled => _isScheduled;

  Future<void> checkLastConfig() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool config = prefs.getBool('isScheduled') ?? false;
    _isScheduled = config;
    scheduledNotification(config);
    notifyListeners();
  }

  Future<bool> scheduledNotification(bool value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('isScheduled', value);
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling Restaurant Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling Restaurant Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
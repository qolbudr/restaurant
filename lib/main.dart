import 'dart:io';
import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:restaurant_app/home.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/provider/restaurant_notifier.dart';
import 'package:restaurant_app/provider/favorite_notifier.dart';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:restaurant_app/utils/notification_helper.dart';
import 'package:restaurant_app/utils/background_service.dart';
import 'package:restaurant_app/view.dart';
import 'package:restaurant_app/common/navigation.dart';
import 'package:provider/provider.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
   final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();

  if (Platform.isAndroid) {
   await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantNotifier>(create: (_) => RestaurantNotifier()),
        ChangeNotifierProvider<FavoriteNotifier>(create: (_) => FavoriteNotifier()),
        ChangeNotifierProvider<SchedulingProvider>(create: (_) => SchedulingProvider()),
      ],
      child: MyApp(),
    )
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyRestaurant',
      theme: ThemeData(
        primaryColor: Color(0xff41c274),
        accentColor: Color(0xff41c274),
        fontFamily: "Poppins",
        scaffoldBackgroundColor: Color(0xfffdfdfd)
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      navigatorKey: navigatorKey,
      routes: {
        '/': (context) => SplashScreen(),
        '/view': (context) => View(ModalRoute.of(context).settings.arguments),
      },
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    checkNotification();
    Timer(Duration(seconds: 1), () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Home()
      ))
    );
  }

  void checkNotification() {
    context.read<SchedulingProvider>().checkLastConfig();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Theme.of(context).primaryColor,
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(Icons.emoji_food_beverage_outlined, color: Colors.white, size: 50),
              SizedBox(height: 10),
              Text("MyRestaurant", style: TextStyle(color: Colors.white, fontSize: 16))
            ]
          ),
        ),
      ),
    );
  }
}


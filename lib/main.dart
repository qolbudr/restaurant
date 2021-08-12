import 'package:flutter/material.dart';
import 'dart:async';
import 'package:restaurant_app/home.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/model/restaurant_notifier.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider<RestaurantNotifier>(create: (_) => RestaurantNotifier()),
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
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
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
    Timer(Duration(seconds: 1), () => Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => Home()
      ))
    );
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


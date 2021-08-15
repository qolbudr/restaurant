import 'package:flutter/material.dart';
import 'dart:io';
import 'package:restaurant_app/provider/scheduling_provider.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/widget/custom_dialog.dart';

class Settings extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back), color: Colors.white
        ),
        title: Text("Settings", style: TextStyle(color: Colors.white, fontSize: 14)),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: [
                ListTile(
                  title: Text('Enable Notification'),
                  trailing: Switch.adaptive(
                    value: context.watch<SchedulingProvider>().isScheduled,
                    onChanged: (value) async {
                      if (Platform.isIOS) {
                        customDialog(context);
                      } else {
                        context.read<SchedulingProvider>().scheduledNotification(value);
                      }
                    },
                  ),
                )
              ],
            )
          )
        ]
      )
    );
  }
}

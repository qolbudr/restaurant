import 'package:flutter/material.dart';
import 'package:restaurant_app/home.dart';
import 'package:restaurant_app/model/restaurant.dart';

class Result extends StatelessWidget {
  final List<Restaurant> result;
  Result({this.result});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back), color: Colors.white
        ),
        title: Text("Search Result", style: TextStyle(color: Colors.white, fontSize: 14)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: (MediaQuery.of(context).size.width / 1) - 5,
                  childAspectRatio: 807 / 540,
                  mainAxisSpacing: 30,
                  crossAxisSpacing: 10,
                ),
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: result.length,
                itemBuilder: (context, index) {
                  return buildListRestaurant(context, result[index]);
                },
              ),
            )
          )
        ]
      )
    );
  }
}

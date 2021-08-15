import 'package:flutter/material.dart';
import 'package:restaurant_app/home.dart';
import 'package:restaurant_app/provider/restaurant_notifier.dart';
import 'package:provider/provider.dart';

class Result extends StatelessWidget {
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
            child: Consumer<RestaurantNotifier>(
              builder: (context, snapshot, child) {
                if(snapshot.searchResult.length == 0) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.warning, size: 30),
                        Text("No Items"),
                      ],
                    )
                  );
                } else {
                  return Padding(
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
                      itemCount: snapshot.searchResult.length,
                      itemBuilder: (context, index) {
                        return buildListRestaurant(context, snapshot.searchResult[index]);
                      },
                    ),
                  );
                }
              }
            )
          )
        ]
      )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restaurant_app/provider/favorite_notifier.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/rating.dart';
import 'package:restaurant_app/view.dart';
import 'package:restaurant_app/model/restaurant.dart';

class Favorite extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back), color: Colors.white
        ),
        title: Text("Favorite", style: TextStyle(color: Colors.white, fontSize: 14)),
      ),
      body: Column(
        children: [
          Expanded(
            child: Consumer<FavoriteNotifier>(
              builder: (context, snapshot, child) {
                if(snapshot.favorite.length == 0) {
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
                      itemCount: snapshot.favorite.length,
                      itemBuilder: (context, index) {
                        return buildListRestaurant(context, snapshot.favorite[index]);
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

Widget buildListRestaurant(BuildContext context, dynamic restaurant) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      image: DecorationImage(
        image: NetworkImage("https://restaurant-api.dicoding.dev/images/medium/" + restaurant["pictureId"]),
        fit: BoxFit.cover,
      ),
    ),
    child: Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            gradient: LinearGradient(
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              colors: [
                Colors.black,
                Colors.black.withOpacity(0)
              ],
              stops: [
                0.3,
                0.7
              ],
            )
          ),
        ),
        InkWell(
          onTap: () => Navigator.push(context, MaterialPageRoute(
            builder: (context) {
              RestaurantList data = RestaurantList.fromJson(restaurant);
              return View(data);
            } 
          )),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurant["name"], style: TextStyle(color: Colors.white, fontSize: 18)),
                Text(restaurant["description"], maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 10)),
                SizedBox(height: 10),
                Row(
                  children: [
                    RatingStar(count: restaurant["rating"].toInt()),
                    VerticalDivider(color: Colors.white, thickness: 2),
                    Icon(Icons.place, color: Colors.white, size: 16),
                    SizedBox(width: 5),
                    Text(restaurant["city"], style: TextStyle(color: Colors.white, fontSize: 14))
                  ],
                )
              ],
            ),
          ),
        )
      ],
    ),
  );
}

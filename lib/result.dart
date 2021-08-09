import 'package:flutter/material.dart';
import 'package:restaurant_app/home.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/service/api_service.dart';

class Result extends StatefulWidget {
  final String query;
  Result({this.query});

  @override
  _ResultState createState() => _ResultState();
}

class _ResultState extends State<Result> {
  Future<ListSearch> _restaurantList;

  @override
  void initState() {
    super.initState();
    _restaurantList = ApiService().getSearchResult(widget.query);
  }

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
            child: FutureBuilder<ListSearch>(
              future: _restaurantList,
              builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.done) {
                  List<RestaurantList> result = snapshot.data.restaurants;
                  if(snapshot.data.founded > 0) {
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
                        itemCount: result.length,
                        itemBuilder: (context, index) {
                          return buildListRestaurant(context, result[index]);
                        },
                      ),
                    );
                  } else {
                    return Center(child: Text("Item not found"));
                  }
                } else if(snapshot.hasError) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("Failed load data"),
                    action: SnackBarAction(
                      label: 'Okay',
                      onPressed: () {
                      },
                    ),
                  ));
                  return Center(child: Text("Failed load data"));
                } else {
                  return Center(child: CircularProgressIndicator());
                }
              }
            )
          )
        ]
      )
    );
  }
}

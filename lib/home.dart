import 'package:flutter/material.dart';
import 'package:restaurant_app/rating.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/view.dart';
import 'package:restaurant_app/result.dart';
import 'dart:async';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<ListRestaurant> _listRestaurant;
  double spacing = 500;

  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 5), () => setState(() {
      spacing = 0;
    }));
    _listRestaurant = ApiService().getList();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text("MyRestaurant", style: TextStyle(color: Colors.white, fontSize: 14)),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Stack(
                children: [
                  Container(
                    color: Theme.of(context).primaryColor,
                    width: double.infinity,
                    height: size.height * 0.3,
                    padding: EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Where do you want to eat today ?", style: TextStyle(color: Colors.white, fontSize: 22)),
                        SizedBox(height: 20),
                        TextField(
                          onSubmitted: (query) {
                            Navigator.push(context, MaterialPageRoute(
                              builder: (context) => Result(query: query)
                            ));
                          },
                          cursorWidth: 1,
                          cursorColor: Theme.of(context).accentColor,
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            hintText: "Find restaurant...",
                            prefixIcon: Icon(Icons.search_outlined),
                            disabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30), 
                              borderSide: BorderSide(color: Colors.transparent)
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30), 
                              borderSide: BorderSide(color: Colors.transparent)
                            ), 
                            focusedBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30), 
                              borderSide: BorderSide(color: Colors.transparent)
                            ),
                            errorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30), 
                              borderSide: BorderSide(color: Colors.transparent)
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderRadius: BorderRadius.circular(30), 
                              borderSide: BorderSide(color: Colors.transparent)
                            )
                          ),
                        ),
                      ],
                    )
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), topRight: Radius.circular(30)),
                    ),
                    width: double.infinity,
                    margin: EdgeInsets.only(top: size.height * 0.25),
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Browse", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                        Text("Find your desired restaurant", style: TextStyle(fontSize: 13, color: Colors.black54)),
                        SizedBox(height: 20),
                        FutureBuilder<ListRestaurant>(
                          future:  _listRestaurant,
                          builder: (context, snapshot) {
                            if(snapshot.connectionState == ConnectionState.done) {
                              List<RestaurantList> data = snapshot.data.restaurants;
                              if(snapshot.data.count > 0) {
                                return Column(
                                  children: [
                                    AnimatedContainer(
                                      duration: Duration(seconds: 2), 
                                      height: spacing,
                                      curve: Curves.easeOut,
                                    ),
                                    GridView.builder(
                                      gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                                        maxCrossAxisExtent: (MediaQuery.of(context).size.width / 1) - 5,
                                        childAspectRatio: 807 / 540,
                                        mainAxisSpacing: 30,
                                        crossAxisSpacing: 10,
                                      ),
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                      itemCount: data.length,
                                      itemBuilder: (context, index) {
                                        return buildListRestaurant(context, data[index]);
                                      },
                                    ),
                                  ],
                                );
                              } else {
                                return Text("Failed load data");
                              }
                            } else if(snapshot.hasError) {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                content: Text("Gagal memuat data"),
                                action: SnackBarAction(
                                  label: 'Okay',
                                  onPressed: () {
                                  },
                                ),
                              ));
                              return Text("Failed load data");
                            } else {
                              return LinearProgressIndicator();
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      )
    );
  }
}

Widget buildListRestaurant(BuildContext context, RestaurantList restaurant) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(20)),
      image: DecorationImage(
        image: NetworkImage("https://restaurant-api.dicoding.dev/images/medium/" + restaurant.pictureId),
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
            builder: (context) => View(id: restaurant.id, pictureId: restaurant.pictureId, title: restaurant.name)
          )),
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(restaurant.name, style: TextStyle(color: Colors.white, fontSize: 18)),
                Text(restaurant.description, maxLines: 2, style: TextStyle(color: Colors.white, fontSize: 10)),
                SizedBox(height: 10),
                Row(
                  children: [
                    RatingStar(count: restaurant.rating.toInt()),
                    VerticalDivider(color: Colors.white, thickness: 2),
                    Icon(Icons.place, color: Colors.white, size: 16),
                    SizedBox(width: 5),
                    Text(restaurant.city, style: TextStyle(color: Colors.white, fontSize: 14))
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

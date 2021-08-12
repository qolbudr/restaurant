import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/rating.dart';
import 'package:restaurant_app/service/api_service.dart';

class View extends StatefulWidget {
  final String id, title, pictureId;
  View({this.id, this.title, this.pictureId});

  @override
  _ViewState createState() => _ViewState();
}

class _ViewState extends State<View> {
  Future<DetailRestaurant> _detailRestaurant;
  final _reviewController = TextEditingController();
  final _nameController = TextEditingController();
  List<CustomerReview> reviews;
  bool isEnabled = false;

  @override
  void initState() {
    super.initState();
    _detailRestaurant = ApiService().getRestaurantById(widget.id);
  }

  @override
  void dispose() {
    _reviewController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  void postReview() async {
    setState(() {
      isEnabled = false;
    });

    await ApiService().postReview(
      widget.id,
      _nameController.value.text,
      _reviewController.value.text
    );

    setState(() {
      reviews.add(CustomerReview(name: _nameController.value.text, review: _reviewController.value.text));
      _nameController.text = "";
      _reviewController.text = "";
    });
  }

  void setEnabled() {
    if(_nameController.value.text != "" && _reviewController.value.text != "") {
      setState(() {
        isEnabled = true;
      });
    } else {
      setState(() {
        isEnabled = false;
      });
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, isScrolled) {
          return [
            SliverAppBar(
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Icon(Icons.arrow_back), color: Colors.white
              ),
              elevation: 0,
              pinned: true,
              expandedHeight: 300,
              title: Text(widget.title, style: TextStyle(color: Colors.white, fontSize: 14)),
              flexibleSpace: FlexibleSpaceBar(
                background: Image.network("https://restaurant-api.dicoding.dev/images/large/" + widget.pictureId, fit: BoxFit.cover),
              ),
            ),
          ];
        },
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: FutureBuilder(
                future: _detailRestaurant,
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
                    RestaurantDetail data = snapshot.data.restaurant;
                    reviews = data.customerReviews;
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(data.name, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
                        Row(
                          children: [
                            RatingStar(count: data.rating.toInt()),
                            VerticalDivider(thickness: 2),
                            Icon(Icons.place, size: 16),
                            SizedBox(width: 5),
                            Text(data.city, style: TextStyle(fontSize: 14))
                          ],
                        ),
                        SizedBox(height: 20),
                        Text("Description", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Text(data.description),
                        SizedBox(height: 20),
                        Text("Foods Menu", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Container(
                          height: 100,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(width: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: data.menus.foods.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                ),
                                padding: EdgeInsets.all(15),
                                width: 200,
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.fastfood_sharp, color:  Theme.of(context).primaryColor, size: 40),
                                    Text(data.menus.foods[index].name, style: TextStyle(color:  Theme.of(context).primaryColor), textAlign: TextAlign.left),
                                  ]
                                )
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Drinks Menu", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        Container(
                          height: 100,
                          child: ListView.separated(
                            separatorBuilder: (context, index) => SizedBox(width: 10),
                            scrollDirection: Axis.horizontal,
                            itemCount: data.menus.drinks.length,
                            itemBuilder: (context, index) {
                              return Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.all(Radius.circular(15)),
                                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                                ),
                                padding: EdgeInsets.all(15),
                                width: 200,
                                height: 100,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(Icons.emoji_food_beverage_outlined, color:  Theme.of(context).primaryColor, size: 40),
                                    Text(data.menus.drinks[index].name, style: TextStyle(color:  Theme.of(context).primaryColor), textAlign: TextAlign.left),
                                  ]
                                )
                              );
                            },
                          ),
                        ),
                        SizedBox(height: 20),
                        Text("Review", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                        SizedBox(height: 10),
                        _buildReviewSection(context, reviews),
                        Divider(),
                        SizedBox(height: 10),
                        Column(
                          children: [
                            TextField(
                              controller: _nameController,
                              decoration: InputDecoration(
                                hintText: "Name",
                              ),
                              onChanged: (value) => setEnabled(),
                            ),
                            SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Expanded(
                                  child: TextField(
                                    onChanged: (value) => setEnabled(),
                                    controller: _reviewController,
                                    decoration: InputDecoration(
                                      hintText: "Post a review..",
                                      suffixIcon: TextButton(
                                        onPressed: isEnabled ? () => postReview() : null,
                                        child: Icon(Icons.send),
                                      )
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 50),
                      ],
                    );
                  } else if(snapshot.hasError) {
                    return Center(
                      child: Column(
                        children: [
                          SizedBox(height: 100),
                          Icon(Icons.airplanemode_off, size: 30),
                          Text("Failed to load data"),
                        ],
                      )
                    );
                  } else {
                    return LinearProgressIndicator();
                  }
                }
              ),
            ),
          ],
        )
      )
    );
  }
}

Widget _buildReviewSection(context, List<CustomerReview> review) {
  return Column(
    children: List.generate(
      review.length, (index) => ListTile(
        leading: Icon(Icons.person, color: Theme.of(context).primaryColor),
        title: Text(review[index].name),
        subtitle: Text(review[index].review),
      )
    ),
  );
}

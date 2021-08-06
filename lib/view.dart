import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/rating.dart';

class View extends StatelessWidget {
	final Restaurant restaurant;

	View({this.restaurant});

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
				      title: Text(restaurant.name, style: TextStyle(color: Colors.white, fontSize: 14)),
				      flexibleSpace: FlexibleSpaceBar(
				      	background: Image.network(restaurant.pictureId, fit: BoxFit.cover),
				      ),
				    ),
				  ];
				},
				body: ListView(
				  children: [
				    Padding(
				      padding: const EdgeInsets.symmetric(horizontal: 15),
				      child: Column(
				      	crossAxisAlignment: CrossAxisAlignment.start,
				      	children: [
				      		Text(restaurant.name, style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
				      		Row(
		  			  			children: [
		  			  				RatingStar(count: restaurant.rating.toInt()),
		  			  				VerticalDivider(thickness: 2),
		  			  				Icon(Icons.place, size: 16),
		  			  				SizedBox(width: 5),
		  			  				Text(restaurant.city, style: TextStyle(fontSize: 14))
		  			  			],
		  			  		),
		  			  		SizedBox(height: 20),
		  			  		Text("Description", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
		  			  		SizedBox(height: 10),
		  			  		Text(restaurant.description),
		  			  		SizedBox(height: 20),
		  			  		Text("Menu", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
		  			  		SizedBox(height: 10),
		  			  		Container(
		  			  			height: 100,
		  			  		  child: ListView.separated(
		  			  		  	separatorBuilder: (context, index) => SizedBox(width: 10),
		  			  		  	scrollDirection: Axis.horizontal,
		  			  		  	itemCount: restaurant.menus.length,
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
		  			  		  					Icon(Icons.food_bank, color:  Theme.of(context).primaryColor, size: 40),
		  			  		  					Text(restaurant.menus[index]["name"], style: TextStyle(color:  Theme.of(context).primaryColor), textAlign: TextAlign.left),
		  			  		  				]
		  			  		  			)
		  			  		  		);
		  			  		  	},
		  			  		  ),
		  			  		)
				      	],
				      ),
				    ),
				  ],
				)
			)
		);
	}
}

import 'package:flutter/material.dart';

class RatingStar extends StatelessWidget {
	RatingStar({this.count});
	final int count;

	Widget buildStar(context, index) {
		if(index >= count) {
			return Icon(Icons.star_border, color: Theme.of(context).accentColor, size: 15);
		} else {
			return Icon(Icons.star, color: Theme.of(context).accentColor, size: 15);
		}
	}

	@override 
	Widget build(BuildContext context) {
		return Row(
			mainAxisAlignment: MainAxisAlignment.start,
			children: List.generate(5, (index) => buildStar(context, index)),
		);
	}
}
import 'dart:convert';

class Restaurant {
	String id, name, description, pictureId, city;
	dynamic rating;
	List<dynamic> menus;

	Restaurant({
		this.id,
		this.name,
		this.description,
		this.pictureId,
		this.city,
		this.rating,
		this.menus,
	});

	Restaurant.fromJson(Map<String, dynamic> restaurant) {
		id = restaurant["id"];
		name = restaurant["name"];
		description = restaurant["description"];
		pictureId = restaurant["pictureId"];
		city = restaurant["city"];
		rating = restaurant["rating"];
		menus = [];
		menus.addAll(restaurant["menus"]["foods"]);
		menus.addAll(restaurant["menus"]["drinks"]);
	}
}

List<Restaurant> parseData(String data) {
	if (data == null) {
    return [];
  }

	var parsedData = jsonDecode(data);
	final List parsed = parsedData['restaurants'];
	return parsed.map((json) => Restaurant.fromJson(json)).toList();
}

List<Restaurant> findRestaurant(String query, List<Restaurant> restaurant) {
	List<Restaurant> result = [];

	restaurant.forEach((data) {
		if(data.name.contains(new RegExp(query, caseSensitive: false))) {
			result.add(data);
		}
	});

	return result;
}
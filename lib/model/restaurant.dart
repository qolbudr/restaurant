import 'dart:convert';

DetailRestaurant detailRestaurantFromJson(String str) => DetailRestaurant.fromJson(json.decode(str));
ListRestaurant listRestaurantFromJson(String str) => ListRestaurant.fromJson(json.decode(str));
ListSearch listSearchFromJson(String str) => ListSearch.fromJson(json.decode(str));

class ListSearch {
    ListSearch({
        this.error,
        this.founded,
        this.restaurants,
    });

    bool error;
    int founded;
    List<RestaurantList> restaurants;

    factory ListSearch.fromJson(Map<String, dynamic> json) => ListSearch(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<RestaurantList>.from(json["restaurants"].map((x) => RestaurantList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "founded": founded,
        "restaurants": List<RestaurantList>.from(restaurants.map((x) => x.toJson())),
    };
}

class ListRestaurant {
    ListRestaurant({
        this.error,
        this.message,
        this.count,
        this.restaurants,
    });

    bool error;
    String message;
    int count;
    List<RestaurantList> restaurants;

    factory ListRestaurant.fromJson(Map<String, dynamic> json) => ListRestaurant(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<RestaurantList>.from(json["restaurants"].map((x) => RestaurantList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "count": count,
        "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
    };
}

class RestaurantList {
    RestaurantList({
        this.id,
        this.name,
        this.description,
        this.pictureId,
        this.city,
        this.rating,
    });

    String id;
    String name;
    String description;
    String pictureId;
    String city;
    double rating;

    factory RestaurantList.fromJson(Map<String, dynamic> json) => RestaurantList(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        pictureId: json["pictureId"],
        city: json["city"],
        rating: json["rating"].toDouble(),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "pictureId": pictureId,
        "city": city,
        "rating": rating,
    };
}

class DetailRestaurant {
    DetailRestaurant({
        this.error,
        this.message,
        this.restaurant,
    });

    bool error;
    String message;
    RestaurantDetail restaurant;

    factory DetailRestaurant.fromJson(Map<String, dynamic> json) => DetailRestaurant(
        error: json["error"],
        message: json["message"],
        restaurant: RestaurantDetail.fromJson(json["restaurant"]),
    );

    Map<String, dynamic> toJson() => {
        "error": error,
        "message": message,
        "restaurant": restaurant.toJson(),
    };
}

class RestaurantDetail {
    RestaurantDetail({
        this.id,
        this.name,
        this.description,
        this.city,
        this.address,
        this.pictureId,
        this.categories,
        this.menus,
        this.rating,
        this.customerReviews,
    });

    String id;
    String name;
    String description;
    String city;
    String address;
    String pictureId;
    List<Category> categories;
    Menus menus;
    double rating;
    List<CustomerReview> customerReviews;

    factory RestaurantDetail.fromJson(Map<String, dynamic> json) => RestaurantDetail(
        id: json["id"],
        name: json["name"],
        description: json["description"],
        city: json["city"],
        address: json["address"],
        pictureId: json["pictureId"],
        categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
        menus: Menus.fromJson(json["menus"]),
        rating: json["rating"].toDouble(),
        customerReviews: List<CustomerReview>.from(json["customerReviews"].map((x) => CustomerReview.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "city": city,
        "address": address,
        "pictureId": pictureId,
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
        "menus": menus.toJson(),
        "rating": rating,
        "customerReviews": List<dynamic>.from(customerReviews.map((x) => x.toJson())),
    };
}

class Category {
    Category({
        this.name,
    });

    String name;

    factory Category.fromJson(Map<String, dynamic> json) => Category(
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
    };
}

class CustomerReview {
    CustomerReview({
        this.name,
        this.review,
        this.date,
    });

    String name;
    String review;
    String date;

    factory CustomerReview.fromJson(Map<String, dynamic> json) => CustomerReview(
        name: json["name"],
        review: json["review"],
        date: json["date"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "review": review,
        "date": date,
    };
}

class Menus {
    Menus({
        this.foods,
        this.drinks,
    });

    List<Category> foods;
    List<Category> drinks;

    factory Menus.fromJson(Map<String, dynamic> json) => Menus(
        foods: List<Category>.from(json["foods"].map((x) => Category.fromJson(x))),
        drinks: List<Category>.from(json["drinks"].map((x) => Category.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "foods": List<dynamic>.from(foods.map((x) => x.toJson())),
        "drinks": List<dynamic>.from(drinks.map((x) => x.toJson())),
    };
}

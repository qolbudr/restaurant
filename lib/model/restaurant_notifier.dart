import 'package:flutter/material.dart';
import 'package:restaurant_app/model/restaurant.dart';
import 'package:restaurant_app/service/api_service.dart';

class RestaurantNotifier extends ChangeNotifier {
  List<RestaurantList> _listRestaurant;
  List<RestaurantList> searchResult;

  List<RestaurantList> get listRestaurant => _listRestaurant;

  RestaurantNotifier() {
    _listRestaurant = [];
    setRestaurantList();
  }

  void setRestaurantList() async {
    ListRestaurant data = await ApiService().getList();
    _listRestaurant = data.restaurants;
    notifyListeners();
  }

  void searchRestaurant(String query) {
    List<RestaurantList> result = [];
    _listRestaurant.forEach((data) {
      if (data.name.contains(new RegExp(query, caseSensitive: false))) {
        result.add(data);
      }
    });

    searchResult = result;

    notifyListeners();
  }
}
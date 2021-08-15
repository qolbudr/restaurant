import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:restaurant_app/model/restaurant.dart';

class FavoriteNotifier extends ChangeNotifier {
  List<dynamic> _favorite;
  bool _isFavorite;

  List<dynamic> get favorite {
    getFavorite();
    return _favorite;
  }

  bool get isFavorite => _isFavorite;

  FavoriteNotifier() {
    _favorite = [];
    _isFavorite = false;
    getFavorite();
  }

  void getFavorite() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String favorite = prefs.getString('favorite') ?? "[]";
    List<dynamic> favorites = jsonDecode(favorite);
    _favorite = favorites;
    notifyListeners();
  }

  void saveFavorite(RestaurantDetail restaurant) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String favorite = prefs.getString('favorite') ?? "[]";
    List<dynamic> favorites = jsonDecode(favorite);
    favorites.add(restaurant.toJson());
    _favorite.add(restaurant.toJson());

    // print(favorites);
    prefs.setString('favorite', jsonEncode(favorites));
    _isFavorite = true;
    notifyListeners();
  } 

  void checkFavorite(id) async {
    _isFavorite = false;
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String favorite = prefs.getString('favorite') ?? "[]";
    List<dynamic> favorites = jsonDecode(favorite);
    favorites.forEach((restaurant) {
      if(restaurant['id'].toString() == id) {
        _isFavorite = true;
      }
    });
    notifyListeners();
  }

  void removeFavorite(id) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    String favorite = prefs.getString('favorite') ?? "[]";
    List<dynamic> favorites = jsonDecode(favorite);
    int index;
    int i = 0;
    favorites.forEach((restaurant) {
      if(restaurant['id'].toString() == id) {
        index = i;
      }

      i++;
    });

    favorites.removeAt(index);
    _favorite.removeAt(index);

    prefs.setString('favorite', jsonEncode(favorites));
    _isFavorite = false;
    notifyListeners();
  }
}
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restaurant_app/model/restaurant.dart';

class ApiService {
  static final _baseURL = "https://restaurant-api.dicoding.dev/";
  static final _apiKey = "12345";

  Future<ListRestaurant> getList() async {
    final response = await http.get(Uri.parse(_baseURL + "list"));
    if(response.statusCode == 200) {
      return listRestaurantFromJson(response.body);
    } else {
      throw Exception("Gagal memuat data...");
    }
  }

  Future<ListSearch> getSearchResult(String query) async {
    final response = await http.get(Uri.parse(_baseURL + "/search?q=" + query));
    if(response.statusCode == 200) {
      return listSearchFromJson(response.body);
    } else {
      throw Exception("Gagal memuat data...");
    }
  }

  Future<DetailRestaurant> getRestaurantById(String id) async {
    final response = await http.get(Uri.parse(_baseURL + "detail/" + id));
    if(response.statusCode == 200) {
      return detailRestaurantFromJson(response.body);
    } else {
      throw Exception("Gagal memuat data...");
    }
  }

  Future<CustomerReview> postReview(String id, String name, String review) async {
    final response = await http.post(
      Uri.parse(_baseURL + "review"), 
      headers: {
        "Content-Type": "application/x-www-form-urlencoded",
        "X-Auth-Token": _apiKey,
      },
      body: "id=" + id + "&name=" + name + "&review=" + review
    );
    if(response.statusCode == 200) {
      return CustomerReview.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Gagal posting review...");
    }
  }
}
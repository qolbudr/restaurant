import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/service/api_service.dart';
import 'package:restaurant_app/model/restaurant.dart';

void main() {
  test('should contain restaurants list', () async {
    // arrange
    var myrestaurant = ListRestaurant();
    var apiService = ApiService();

    //act
    myrestaurant = await apiService.getList();

    //assert
    var result = myrestaurant.restaurants != null;
    expect(result, true);
  });
}
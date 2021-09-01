import 'package:flutter_test/flutter_test.dart';
import 'package:restoran_dicoding/data/api/api_service.dart';
import 'package:http/http.dart' as http;

void main() {
  final apiService = ApiService();
  test('fetch nama restaurant', () async {
    final listRestaurant = await apiService.getListRestaurant(http.Client());
    var restaurant = listRestaurant.restaurants[0];
    expect(restaurant.name, "Melting Pot");
  });

  test('fetch jumlah restaurant', () async {
    final listRestaurant = await apiService.getListRestaurant(http.Client());
    var restaurant = listRestaurant.restaurants;
    expect(restaurant.length, 20);
  });
}

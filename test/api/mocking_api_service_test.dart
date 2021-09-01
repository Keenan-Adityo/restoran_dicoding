import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:restoran_dicoding/data/api/api_service.dart';
import 'package:restoran_dicoding/data/model/restaurantlist.dart';

class MockClient extends Mock implements http.Client {}

void main() {
  test('cek nama restaurant pertama!', () async {
    final mockClient = MockClient();
    var httpResponse = http.Response('''{
    "error": false,
    "message": "success",
    "count": 20,
    "restaurants": [
        {
            "id": "rqdv5juczeskfw1e867",
            "name": "Melting Pot",
            "description": "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. ...",
            "pictureId": "14",
            "city": "Medan",
            "rating": 4.2
        },
        {
            "id": "s1knt6za9kkfw1e867",
            "name": "Kafe Kita",
            "description": "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
            "pictureId": "25",
            "city": "Gorontalo",
            "rating": 4
        }
    ]
}''', 200);

    when(() => mockClient
            .get(Uri.parse('https://restaurant-api.dicoding.dev/list')))
        .thenAnswer((_) async => httpResponse);
    var apiService = ApiService();
    var response = await apiService.getListRestaurant(mockClient);
    var expectedResponse =
        RestaurantListApi.fromJson(jsonDecode(httpResponse.body));

    expect(response.restaurants.first.name,
        expectedResponse.restaurants.first.name);
  });
}

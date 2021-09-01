import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:restoran_dicoding/data/model/restaurantlist.dart';

class ApiService {
  static final String _baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantListApi> getListRestaurant(http.Client client) async {
    final response = await client.get(Uri.parse(_baseUrl + "/list"));
    if (response.statusCode == 200) {
      return RestaurantListApi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Failed to Restaurant List');
    }
  }

  Future<RestaurantApi> getDetailRestaurant(String restoId) async {
    final response = await http.get(Uri.parse(_baseUrl + '/detail/' + restoId));
    if (response.statusCode == 200) {
      return RestaurantApi.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Maaf detail restonya sedang bermasalah');
    }
  }

  Future<Search> getSearchRestaurant(String search) async {
    final response =
        await http.get(Uri.parse(_baseUrl + '/search?q=' + search));
    if (response.statusCode == 200) {
      return Search.fromJson(jsonDecode(response.body));
    } else {
      throw Exception('Maaf fitur ini belum dapat digunakan');
    }
  }

  Future<Review> postAddReview(String name, String review, String id) async {
    Map data = {
      "name": name,
      "review": review,
      "id": id,
    };

    final response = await http.post(
      Uri.parse(_baseUrl + '/review'),
      headers: {
        'Content-Type': 'application/json',
        'X-Auth-Token': '12345',
      },
      body: json.encode(data),
    );

    print(response.body);
    if (response.statusCode == 200) {
      final String responseString = response.body;
      return reviewFromJson(responseString);
    } else {
      print(name);
      throw Exception('Ngga masuk reviewnya');
    }
  }
}

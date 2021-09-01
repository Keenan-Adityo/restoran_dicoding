import 'package:android_alarm_manager/android_alarm_manager.dart';
import 'package:flutter/material.dart';
import 'package:restoran_dicoding/data/api/api_service.dart';
import 'package:restoran_dicoding/data/model/restaurantlist.dart';
import 'package:restoran_dicoding/utils/background_services.dart';
import 'package:restoran_dicoding/utils/date_time_helper.dart';
import 'package:restoran_dicoding/utils/db_helper.dart';
import 'package:restoran_dicoding/utils/preference_helper.dart';
import 'package:http/http.dart' as http;

part 'alarm_provider.dart';
part 'preference_provider.dart';
part 'favorite_provider.dart';

enum ResultState { Loading, NoData, HasData, Error }

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurant();
  }

  late RestaurantListApi _restaurantListApi;
  String _message = '';
  late ResultState _state;
  late ResultState _detailState;
  late ResultState _reviewState;
  ResultState _searchState = ResultState.NoData;
  late Restaurant _restaurant;
  late Search _search;
  late Review _review;

  String get message => _message;
  RestaurantListApi get result => _restaurantListApi;
  Restaurant get detailresult => _restaurant;
  Search get searchresult => _search;
  Review get reviewresult => _review;
  ResultState get state => _state;
  ResultState get detailState => _detailState;
  ResultState get searchState => _searchState;
  ResultState get reviewState => _reviewState;

  Future<dynamic> _fetchAllRestaurant() async {
    try {
      _state = ResultState.Loading;
      notifyListeners();
      final resto = await apiService.getListRestaurant(http.Client());
      if (resto.restaurants.isEmpty) {
        _state = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState.HasData;
        notifyListeners();
        return _restaurantListApi = resto;
      }
    } catch (e) {
      _state = ResultState.Error;
      notifyListeners();
      return _message = 'Maaf koneksi anda terputus.';
    }
  }

  Future<dynamic> fetchRestaurant(String restoId) async {
    try {
      _detailState = ResultState.Loading;
      notifyListeners();
      final detailResto = await apiService.getDetailRestaurant(restoId);
      if (detailResto.restaurant.id.isEmpty) {
        _detailState = ResultState.NoData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _detailState = ResultState.HasData;
        notifyListeners();
        return _restaurant = detailResto.restaurant;
      }
    } catch (e) {
      _detailState = ResultState.Error;
      notifyListeners();
      return _message = 'Maaf koneksi anda terputus.';
    }
  }

  Future<dynamic> fetchSearchRestaurant(String search) async {
    try {
      _searchState = ResultState.Loading;
      notifyListeners();
      final searchresult = await apiService.getSearchRestaurant(search);
      if (searchresult.restaurants.isEmpty) {
        _searchState = ResultState.NoData;
        notifyListeners();
        return _message =
            'Tidak ada restoran dengan nama atau menu itu disini.';
      } else {
        _searchState = ResultState.HasData;
        notifyListeners();
        return _search = searchresult;
      }
    } catch (e) {
      _searchState = ResultState.Error;
      notifyListeners();
      return _message = 'Maaf koneksi anda terputus.';
    }
  }

  Future<dynamic> fetchAddReview(String name, String review, String id) async {
    try {
      _reviewState = ResultState.Loading;
      notifyListeners();
      final reviewResult = await apiService.postAddReview(name, review, id);
      if (reviewresult.customerReviews.isEmpty) {
        _reviewState = ResultState.NoData;
        notifyListeners();
        return _message =
            'Tidak ada restoran dengan nama atau menu itu disini.';
      } else {
        _reviewState = ResultState.HasData;
        notifyListeners();
        return _review = reviewResult;
      }
    } catch (e) {
      _reviewState = ResultState.Error;
      notifyListeners();
      return _message = 'Maaf koneksi anda terputus.';
    }
  }
}

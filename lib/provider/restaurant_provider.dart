import 'package:flutter/material.dart';
import '../data/api/api_service.dart';
import '../data/api/result_state.dart';
import '../data/model/restaurant.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    _fetchAllRestaurants();
  }

  ResultState<List<Restaurant>> _listState = ResultNone();
  ResultState<List<Restaurant>> get listState => _listState;

  ResultState<Restaurant> _detailState = ResultNone();
  ResultState<Restaurant> get detailState => _detailState;

  Future<void> _fetchAllRestaurants() async {
    _listState = ResultLoading();
    notifyListeners();
    try {
      final result = await apiService.getList();
      if (result.isEmpty) {
        _listState = ResultError("Data tidak ditemukan");
      } else {
        _listState = ResultSuccess(result);
      }
    } catch (e) {
      _listState = ResultError("Terjadi kesalahan koneksi");
    }
    notifyListeners();
  }

  Future<void> fetchDetail(String id) async {
    _detailState = ResultLoading();
    notifyListeners();
    try {
      final result = await apiService.getDetail(id);
      _detailState = ResultSuccess(result);
    } catch (e) {
      _detailState = ResultError("Gagal memuat detail");
    }
    notifyListeners();
  }
}

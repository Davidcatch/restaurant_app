import 'package:flutter/foundation.dart';
import '../data/api/api_service.dart';
import '../data/api/result_state.dart';
import '../data/model/restaurant_result.dart';

class RestaurantProvider extends ChangeNotifier {
  final ApiService apiService;

  RestaurantProvider({required this.apiService}) {
    fetchAllRestaurant();
  }

  ResultState _listState = ResultNone();
  ResultState get listState => _listState;

  ResultState _detailState = ResultNone();
  ResultState get detailState => _detailState;

  Future<void> fetchAllRestaurant() async {
    try {
      _listState = ResultLoading();
      notifyListeners();
      final result = await apiService.list();
      if (result.restaurants.isEmpty) {
        _listState = ResultError(message: 'No Data');
      } else {
        _listState = ResultSuccess(data: result.restaurants);
      }
    } catch (e) {
      _listState = ResultError(message: 'Error: $e');
    }
    notifyListeners();
  }

  Future<void> fetchDetail(String id) async {
    try {
      _detailState = ResultLoading();
      notifyListeners();
      final result = await apiService.getDetail(id);
      _detailState = ResultSuccess(data: result);
    } catch (e) {
      _detailState = ResultError(message: 'Error: $e');
    }
    notifyListeners();
  }
}

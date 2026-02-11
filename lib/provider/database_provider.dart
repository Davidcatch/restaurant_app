import 'package:flutter/foundation.dart';
import '../data/db/database_helper.dart';
import '../data/model/restaurant_result.dart';
import '../data/api/result_state.dart';

class DatabaseProvider extends ChangeNotifier {
  final DatabaseHelper databaseHelper;

  DatabaseProvider({required this.databaseHelper}) {
    _getFavorites();
  }

  ResultState _state = ResultLoading();
  ResultState get state => _state;

  String _message = '';
  String get message => _message;

  List<Restaurant> _favorites = [];
  List<Restaurant> get favorites => _favorites;

  void _getFavorites() async {
    try {
      _state = ResultLoading();
      notifyListeners();
      _favorites = await databaseHelper.getFavorites();
      if (_favorites.isNotEmpty) {
        _state = ResultSuccess(data: _favorites);
      } else {
        _state = ResultError(message: 'Empty Data');
      }
    } catch (e) {
      _state = ResultError(message: 'Error: $e');
    }
    notifyListeners();
  }

  void addFavorite(Restaurant restaurant) async {
    try {
      await databaseHelper.insertFavorite(restaurant);
      _getFavorites();
    } catch (e) {
      _state = ResultError(message: 'Error: $e');
      notifyListeners();
    }
  }

  Future<bool> isFavorited(String id) async {
    final favoritedRestaurant = await databaseHelper.getFavoriteById(id);
    return favoritedRestaurant.isNotEmpty;
  }

  void removeFavorite(String id) async {
    try {
      await databaseHelper.removeFavorite(id);
      _getFavorites();
    } catch (e) {
      _state = ResultError(message: 'Error: $e');
      notifyListeners();
    }
  }
}

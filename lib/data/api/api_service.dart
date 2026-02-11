import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/restaurant_result.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev';

  Future<RestaurantResult> list() async {
    final response = await http.get(Uri.parse("$baseUrl/list"));
    if (response.statusCode == 200) {
      return RestaurantResult.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load top headlines');
    }
  }

  Future<Restaurant> getDetail(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Restaurant.fromJson(data['restaurant']);
    } else {
      throw Exception('Failed to load detail');
    }
  }
}

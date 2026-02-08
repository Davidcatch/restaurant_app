import 'dart:convert';
import 'package:http/http.dart' as http;
import '../model/restaurant.dart';

class ApiService {
  static const String baseUrl = 'https://restaurant-api.dicoding.dev/';

  Future<List<Restaurant>> getList() async {
    final response = await http.get(Uri.parse("$baseUrl/list"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['restaurants'] as List)
          .map((e) => Restaurant.fromJson(e))
          .toList();
    } else {
      throw Exception('Gagal memuat data restoran');
    }
  }

  Future<Restaurant> getDetail(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/detail/$id"));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Restaurant.fromJson((data['restaurant']));
    } else {
      throw Exception('Gagal memuat detail restoran');
    }
  }
}

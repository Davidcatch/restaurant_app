import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';

void main() {
  group('Restaurant API & Model Test', () {
    test('Harus berhasil mem-parsing JSON menjadi objek Restaurant', () {
      final Map<String, dynamic> jsonMap = {
        "id": "rqdv5juczeskfw1e867",
        "name": "Melting Pot",
        "description": "Restoran yang sangat enak.",
        "pictureId": "14",
        "city": "Medan",
        "rating": 4.2,
      };

      var restaurant = Restaurant.fromJson(jsonMap);

      expect(restaurant.id, "rqdv5juczeskfw1e867");
      expect(restaurant.name, "Melting Pot");
      expect(restaurant.city, "Medan");
      expect(restaurant.rating, 4.2);
    });
  });
}

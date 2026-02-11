import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_app/data/api/api_service.dart';
import 'package:restaurant_app/data/api/result_state.dart';
import 'package:restaurant_app/data/model/restaurant_result.dart';
import 'package:restaurant_app/provider/restaurant_provider.dart';

class FakeApiService extends ApiService {
  @override
  Future<RestaurantResult> list() async {
    await Future.delayed(const Duration(milliseconds: 500));

    return RestaurantResult(
      error: false,
      message: "success",
      count: 0,
      restaurants: [],
    );
  }
}

void main() {
  group('Restaurant Provider Test', () {
    test('Initial state should be loading/none', () {
      final fakeApi = FakeApiService();

      final provider = RestaurantProvider(apiService: fakeApi);

      expect(provider.listState, isA<ResultLoading>());
    });
  });
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/api/result_state.dart';
import '../provider/database_provider.dart';
import 'restaurant_detail_page.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Favorite Restaurants')),
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state is ResultLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (provider.state is ResultSuccess) {
            final favorites = (provider.state as ResultSuccess).data;
            if (favorites.isEmpty) {
              return const Center(child: Text("Belum ada favorit"));
            }
            return ListView.builder(
              itemCount: favorites.length,
              itemBuilder: (context, index) {
                final restaurant = favorites[index];
                return InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            RestaurantDetailPage(restaurantId: restaurant.id),
                      ),
                    );
                  },
                  child: Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 8,
                    ),
                    child: Row(
                      children: [
                        ClipRRect(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(4),
                            bottomLeft: Radius.circular(4),
                          ),
                          child: Image.network(
                            "https://restaurant-api.dicoding.dev/images/small/${restaurant.pictureId}",
                            width: 100,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (ctx, error, _) => const SizedBox(
                              width: 100,
                              height: 80,
                              child: Icon(Icons.error),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                restaurant.name,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                              Row(
                                children: [
                                  const Icon(Icons.location_on, size: 16),
                                  Text(
                                    restaurant.city,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                    size: 16,
                                  ),
                                  Text(restaurant.rating.toString()),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return Center(child: Text(provider.message));
          }
        },
      ),
    );
  }
}

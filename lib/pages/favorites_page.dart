import 'package:cross_platform_rendu/pages/media_query_pages/mobile_home_view.dart';
import 'package:cross_platform_rendu/pages/media_query_pages/tablet_home_view.dart';
import 'package:cross_platform_rendu/providers/favorites_provide.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/repository_provider.dart';

class FavoritesPage extends ConsumerWidget {
  const FavoritesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;

    final dogState = ref.watch(allDogsProvider);
    final favoriteIds = ref.watch(favoritesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My favorites'),
      ),
      body: dogState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
        data: (dogs) {
          final favoriteDogs = dogs.where((dog) {
            return favoriteIds.contains(dog.id.toString());
          }).toList();

          if (favoriteDogs.isEmpty) {
            return const Center(
              child: Text(
                "You don't have any new favorites yet !", 
                style: TextStyle(fontSize: 16),
              ),
            );
          }

          if (screenWidth < 600) {
            return MobileHomeView(dogs: favoriteDogs); 
          } else {
            return TabletHomeView(dogs: favoriteDogs, screenWidth: screenWidth);
          }
        },
      ),
    );
  }
}
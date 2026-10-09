import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';


class FavoritesNotifier extends Notifier<List<String>> {
  static const _storageKey = 'favorite_dogs'; 

  @override
  List<String> build() {
    _loadFavorites();
    return []; 
  }

  Future<void> _loadFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final savedFavorites = prefs.getStringList(_storageKey) ?? [];
    state = savedFavorites;
  }

  Future<void> toggleFavorite(String dogId) async {
    final prefs = await SharedPreferences.getInstance();

    final currentFavorites = state.toList(); 

    if (currentFavorites.contains(dogId)) {
      currentFavorites.remove(dogId);
    } else {
      currentFavorites.add(dogId);
    }

    await prefs.setStringList(_storageKey, currentFavorites);
    
    state = currentFavorites; 
  }
}

final favoritesProvider = NotifierProvider<FavoritesNotifier, List<String>>(() {
  return FavoritesNotifier();
});
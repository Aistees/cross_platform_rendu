import 'package:cross_platform_rendu/models/dog_home_page_model.dart';
import 'package:cross_platform_rendu/providers/favorites_provide.dart';
import 'package:cross_platform_rendu/providers/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class MobileHomeView extends ConsumerWidget {
  final List<DogHomeModel> dogs;

  const MobileHomeView({super.key, required this.dogs});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final searchQuery = ref.watch(searchQueryProvider);
    final favorite = ref.watch(favoritesProvider);
    
    
    final filteredDogs = dogs.where((dog) {
      return dog.name.toLowerCase().contains(searchQuery.toLowerCase());
    }).toList();
    

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: TextField(
            onChanged: (value) => ref.read(searchQueryProvider.notifier).updateSearch(value),
            decoration: InputDecoration(
              hintText: 'Search a race...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: searchQuery.isNotEmpty 
                  ? IconButton(
                      icon: const Icon(Icons.clear),
                      onPressed: () => ref.read(searchQueryProvider.notifier).updateSearch(''),
                    )
                  : null,
              filled: true,
              fillColor: Theme.of(context).cardTheme.color,
              contentPadding: const EdgeInsets.symmetric(vertical: 0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),

        Expanded(
          child: filteredDogs.isEmpty 
            ? const Center(child: Text("No dogs found"))
            : ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: filteredDogs.length,
                itemBuilder: (context, index) {
                  final dog = filteredDogs[index];
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 2,
                    margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                    child: ListTile(
                      contentPadding: const EdgeInsets.all(8),
                      leading: SizedBox(
                        width: 60,
                        height: 60,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: dog.image.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: dog.image,
                                  fit: BoxFit.cover,
                                  memCacheWidth: 400,
                                  placeholder: (context, url) => const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                                  errorWidget: (context, url, error) => const Icon(Icons.broken_image, color: Colors.grey),
                                )
                              : const Icon(Icons.pets, color: Colors.grey),
                        ),
                      ),
                      title: Text(
                        dog.name,
                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      trailing: IconButton(
                        icon: Icon(
                          favorite.contains(dog.id.toString()) 
                              ? Icons.star 
                              : Icons.star_border,
                          color: favorite.contains(dog.id.toString()) 
                              ? Colors.amber
                              : Colors.grey,
                        ),
                        onPressed: () {
                          ref.read(favoritesProvider.notifier).toggleFavorite(dog.id.toString());
                        },
                      ),
                      onTap: () => context.push('/details/${dog.id}'), 
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }
}
import 'package:cross_platform_rendu/models/dog_home_page_model.dart';
import 'package:cross_platform_rendu/providers/favorites_provide.dart';
import 'package:cross_platform_rendu/providers/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

class TabletHomeView extends ConsumerWidget {
  final List<DogHomeModel> dogs;
  final double screenWidth;

  const TabletHomeView({super.key, required this.dogs, required this.screenWidth});

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
            : GridView.builder(
                padding: const EdgeInsets.all(8.0),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: screenWidth > 900 ? 4 : 3,
                  crossAxisSpacing: 10.0,
                  mainAxisSpacing: 10.0,
                  childAspectRatio: 0.8,
                ),
                itemCount: filteredDogs.length,
                itemBuilder: (context, index) {
                  final dog = filteredDogs[index];                
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    elevation: 3,
                    clipBehavior: Clip.antiAlias,
                    child: InkWell(
                      onTap: () => context.push('/details/${dog.id}'),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: dog.image.isNotEmpty
                                ? CachedNetworkImage(
                                    imageUrl: dog.image,
                                    fit: BoxFit.cover,
                                    memCacheWidth: 400, 
                                    placeholder: (context, url) => const Center(child: CircularProgressIndicator()),
                                    errorWidget: (context, url, error) => const Icon(Icons.broken_image, size: 40, color: Colors.grey),
                                  )
                                : const Icon(Icons.pets, size: 40, color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              dog.name,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
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
                        ],
                      ),
                    ),
                  );
                },
              ),
        ),
      ],
    );
  }
}
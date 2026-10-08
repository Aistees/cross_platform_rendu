import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/repository_provider.dart';
import '../widgets/pagination_controls.dart';

class HomePage extends ConsumerWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final dogState = ref.watch(multipleDogProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adopte un Wouf'),
      ),
      body: dogState.when( 
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, StackTrace) => Center(child: Text('Error: $error')),
        data: (dogs) => Column(
            children: [
              Expanded(
                child: GridView.builder(
                  padding: const EdgeInsets.all(8.0),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, 
                    crossAxisSpacing: 10.0,
                    mainAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                  ),
                  itemCount: dogs.length,
                  itemBuilder: (context, index) {
                    final dog = dogs[index];                
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
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
                                    memCacheWidth: 300, // Même principe d'optimisation mémoire
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
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        bottomNavigationBar: const PaginationControls(),
      );
  }
}

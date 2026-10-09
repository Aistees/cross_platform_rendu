import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../providers/repository_provider.dart';
import '../widgets/pagination_controls.dart';

import 'media_query_pages/mobile_home_view.dart';
import 'media_query_pages/tablet_home_view.dart';

class HomePage extends ConsumerWidget {
  final String title;

  const HomePage({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final screenWidth = MediaQuery.of(context).size.width;
    final searchQuery = ref.watch(searchQueryProvider);
    
    final dogState = searchQuery.trim().isEmpty
        ? ref.watch(multipleDogProvider)
        : ref.watch(allDogsProvider);

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Adopt a Woof',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(width: 12),
            TextButton.icon(
              onPressed: () => context.push('/favorites'),
              label: const Text('Favorites'),
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.onSurface,
                backgroundColor: Theme.of(context).colorScheme.surfaceContainerHighest.withValues(alpha: 0.5),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                visualDensity: VisualDensity.compact,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
            ),
          ],
        ),
      ),
      body: dogState.when( 
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, StackTrace) => Center(child: Text('Error: $error')),
        data: (dogs) {
          if (screenWidth < 600) {
            return MobileHomeView(dogs: dogs);
          } else {
            return TabletHomeView(dogs: dogs, screenWidth: screenWidth);
          }
        },
      ),
      bottomNavigationBar: const PaginationControls(),
    );
  }
}
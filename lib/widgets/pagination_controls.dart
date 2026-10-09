import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/page_provider.dart';

class PaginationControls extends ConsumerWidget {
  const PaginationControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPage = ref.watch(pageProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          onPressed: () => ref.read(pageProvider.notifier).previousPage(),
          child: const Text('Previous'),
        ),
        
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text('Page $currentPage'),
        ),
        
        ElevatedButton(
          onPressed: () => ref.read(pageProvider.notifier).nextPage(),
          child: const Text('Next'),
        ),
      ],
    );
  }
}
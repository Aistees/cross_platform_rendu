import 'package:cached_network_image/cached_network_image.dart';
import 'package:cross_platform_rendu/providers/repository_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class DetailsPage extends ConsumerWidget {
  final String id;
  final String title;

  const DetailsPage({super.key, required this.title, required this.id});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

  final dogState = ref.watch(oneDogProvider(id));

    return Scaffold(
      appBar: AppBar(
        title: Text('Details'),
      ),
      body: dogState.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, StackTrace) => Center(child: Text('Error: $error')),
        data: (dog) =>  SingleChildScrollView(
          child:Padding(
          padding: const EdgeInsets.all(16.0),
          child:Column(
            crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: AspectRatio(
                        aspectRatio: 1.0,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            imageUrl: dog.imageUrl,
                            progressIndicatorBuilder: (context, url, downloadProgress) => 
                            CircularProgressIndicator(value: downloadProgress.progress),
                            fit:BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 30),
                    Expanded(
                      flex: 6, 
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            dog.name,
                            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          if (dog.origin.country != 'Unknown') ...[
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                const Icon(Icons.public, size: 16, color: Colors.grey),
                                const SizedBox(width: 4),
                                Expanded( 
                                  child: Text(
                                    "${dog.origin.country} (${dog.origin.era})",
                                    style: const TextStyle(color: Colors.grey, fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ],
                            ),
                          ],
                          const SizedBox(height: 12),
                          Text(
                            dog.description,
                            style: const TextStyle(fontSize: 14),
                            maxLines: 6,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                const Text("Temper", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: dog.traits.temperament.map((temp) {
                    return Chip(
                      label: Text(temp, style: const TextStyle(fontSize: 12)),
                      backgroundColor: Colors.blue.withValues(alpha: 0.1),
                      side: BorderSide.none,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                const Text("Physic & Health", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(child: _buildStatCard("Weight (M)", "${dog.maleWeight.min}-${dog.maleWeight.max} kg")),
                    const SizedBox(width: 10),
                    Expanded(child: _buildStatCard("Height (M)", "${dog.maleHeight.min}-${dog.maleHeight.max} cm")),
                    const SizedBox(width: 10),
                    Expanded(child: _buildStatCard("Weight (F)", "${dog.femaleWeight.min}-${dog.femaleWeight.max} kg")),
                    const SizedBox(width: 10),
                    Expanded(child: _buildStatCard("Height (F)", "${dog.femaleHeight.min}-${dog.femaleHeight.max} cm")),
                    const SizedBox(width: 10),
                    Expanded(child: _buildStatCard("Life expectancy:", "${dog.lifeMin}-${dog.lifeMax} years")),
                  ],
                ),
                
                const SizedBox(height: 8),
                if (dog.hypoallergenic)
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.green.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.health_and_safety, color: Colors.green),
                        SizedBox(width: 12),
                        Text("Race hypoallergénique", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),

                const SizedBox(height: 24),

                const Text("Caracteristics", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 12),
                _buildTraitBar("Energy", dog.traits.energy),
                _buildTraitBar("Easiest to educate", dog.traits.trainability),
                _buildTraitBar("Barking", dog.traits.barking),
                _buildTraitBar("Good with kids", dog.traits.goodWithChildren),
                _buildTraitBar("Good with other dogs", dog.traits.goodWithDogs),
                _buildTraitBar("Adapted to appartement", dog.traits.apartmentFriendly),

                const SizedBox(height: 40),
              ]
            ),
          ),
        ),
      ),
    );
  }
  Widget _buildStatCard(String title, String value) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      decoration: BoxDecoration(
        color: Colors.grey.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey.withValues(alpha: 0.2)),
      ),
      child: Column(
        children: [
          Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          const SizedBox(height: 4),
          Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildTraitBar(String label, int value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Text(label, style: const TextStyle(fontSize: 14)),
          ),
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: value / 5, 
                minHeight: 8,
                backgroundColor: Colors.grey.withValues(alpha: 0.2),
                color: Colors.blueAccent,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

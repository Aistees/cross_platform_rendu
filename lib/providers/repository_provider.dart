import 'package:cross_platform_rendu/models/dog_details_model.dart';
import 'package:cross_platform_rendu/models/dog_home_page_model.dart';
import 'package:cross_platform_rendu/providers/page_provider.dart';
import 'package:cross_platform_rendu/providers/search_query_provider.dart';
import 'package:cross_platform_rendu/repositories/api_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod/riverpod.dart';

final apiRepositoryProvider = Provider<ApiRepository>((ref) {
  return ApiRepository();
});


final multipleDogProvider = FutureProvider<List<DogHomeModel>>((ref) async {

  final currentPage = ref.watch(pageProvider);
  final repository = ref.read(apiRepositoryProvider);

  return await repository.fetchAllDogsPaginated(currentPage);
});

final oneDogProvider = FutureProvider.family<DogDetailsModel, String>((ref, id) async {

  final repository = ref.read(apiRepositoryProvider);
  
  return await repository.fetchOneDogById(id);
});

final allDogsProvider = FutureProvider<List<DogHomeModel>>((ref) async {
  final repository = ref.watch(apiRepositoryProvider);
  return repository.fetchAllDogs();
});


final searchQueryProvider = NotifierProvider<SearchQueryNotifier, String>(() {
  return SearchQueryNotifier();
});

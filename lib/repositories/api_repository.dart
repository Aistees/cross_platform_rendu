import 'dart:convert';
import 'package:cross_platform_rendu/models/dog_details_model.dart';
import 'package:cross_platform_rendu/models/dog_home_page_model.dart';
import 'package:http/http.dart' as http;

class ApiRepository {

  Future<List<DogHomeModel>> fetchAllDogsPaginated(int page) async {
    String urlFetchAllDogsByPage = "https://dogapi.dog/api/v2/breeds?page[number]=$page";
    print(urlFetchAllDogsByPage);

    try {
      final response = await http.get(Uri.parse(urlFetchAllDogsByPage));
      if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          final List<dynamic> dataList = jsonResponse['data'] ?? [];
      
          return dataList.map((data) => DogHomeModel.fromJson(data)).toList();
        } else {
          throw Exception('Failed to load items: ${response.statusCode}');
        }
    } catch (e) {
      throw Exception('Network error: $e');
    }
  }

  Future<DogDetailsModel> fetchOneDogById(String id) async {
    String urlFetchOneDogById = "https://dogapi.dog/api/v2/breeds/$id";
    
    try {
      final response = await http.get(Uri.parse(urlFetchOneDogById));
      if (response.statusCode == 200) {
          final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
          final Map<String, dynamic> data = jsonResponse['data'];
      
          return  DogDetailsModel.fromJson(data);
        } else {
          throw Exception('Failed to load items: ${response.statusCode}');
        }
    } catch(e) {
      throw Exception('Network error $e');
    }
  }

Future<List<DogHomeModel>> fetchAllDogs() async {
  final List<DogHomeModel> allDogs = [];
  String? nextUrl = "https://dogapi.dog/api/v2/breeds";

  try {
    while (nextUrl != null) {
      final response = await http.get(Uri.parse(nextUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
        final List<dynamic> data = jsonResponse['data'] ?? [];

        allDogs.addAll(
          data.map((dog) => DogHomeModel.fromJson(dog)).toList(),
        );

        final Map<String, dynamic>? links = jsonResponse['links'];
        nextUrl = links?['next'];
      } else {
        throw Exception('Erreur API: ${response.statusCode}');
      }
    }
    return allDogs;
  } catch (e) {
    throw Exception('Erreur réseau: $e');
  }
}
}
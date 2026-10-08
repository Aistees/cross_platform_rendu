class DogHomeModel {
  final String id;
  final String image;
  final String name;

  DogHomeModel({
    required this.id,
    required this.image,
    required this.name,
  });

  factory DogHomeModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>;
    
    String imageUrl = '';
    if (attributes['images'] != null && (attributes['images'] as List).isNotEmpty) {
      imageUrl = attributes['images'][0]['url'] as String;
    }
    
    return DogHomeModel(
      id: json['id'] as String,
      name: attributes['name'] as String,
      image: imageUrl, 
    );
  }
}
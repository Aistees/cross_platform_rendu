class DogDetailsModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;
  final bool hypoallergenic;
  final int lifeMin;
  final int lifeMax;
  final List<String> otherNames;
  
  final DogMeasurement maleWeight;
  final DogMeasurement femaleWeight;
  final DogMeasurement maleHeight;
  final DogMeasurement femaleHeight;
  final DogOrigin origin;
  final DogCoat coat;
  final DogTraits traits;

  DogDetailsModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.hypoallergenic,
    required this.lifeMin,
    required this.lifeMax,
    required this.otherNames,
    required this.maleWeight,
    required this.femaleWeight,
    required this.maleHeight,
    required this.femaleHeight,
    required this.origin,
    required this.coat,
    required this.traits,
  });

  factory DogDetailsModel.fromJson(Map<String, dynamic> json) {
    final attributes = json['attributes'] as Map<String, dynamic>? ?? {};
    
    String parsedImageUrl = '';
    if (attributes['images'] != null && (attributes['images'] as List).isNotEmpty) {
      parsedImageUrl = attributes['images'][0]['url'] as String;
    }

    final life = attributes['life'] as Map<String, dynamic>?;

    return DogDetailsModel(
      id: json['id'] as String,
      name: attributes['name'] as String? ?? 'Inconnu',
      description: attributes['description'] as String? ?? 'Pas de description.',
      imageUrl: parsedImageUrl,
      hypoallergenic: attributes['hypoallergenic'] as bool? ?? false,
      lifeMin: life?['min'] as int? ?? 0,
      lifeMax: life?['max'] as int? ?? 0,
      otherNames: (attributes['other_names'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      maleWeight: DogMeasurement.fromJson(attributes['male_weight'] as Map<String, dynamic>?),
      femaleWeight: DogMeasurement.fromJson(attributes['female_weight'] as Map<String, dynamic>?),
      maleHeight: DogMeasurement.fromJson(attributes['male_height'] as Map<String, dynamic>?),
      femaleHeight: DogMeasurement.fromJson(attributes['female_height'] as Map<String, dynamic>?),
      origin: DogOrigin.fromJson(attributes['origin'] as Map<String, dynamic>?),
      coat: DogCoat.fromJson(attributes['coat'] as Map<String, dynamic>?),
      traits: DogTraits.fromJson(attributes['traits'] as Map<String, dynamic>?),
    );
  }
}

class DogMeasurement {
  final int min;
  final int max;

  DogMeasurement({required this.min, required this.max});

  factory DogMeasurement.fromJson(Map<String, dynamic>? json) {
    return DogMeasurement(
      min: json?['min'] as int? ?? 0,
      max: json?['max'] as int? ?? 0,
    );
  }
}

class DogOrigin {
  final String country;
  final String region;
  final String era;

  DogOrigin({required this.country, required this.region, required this.era});

  factory DogOrigin.fromJson(Map<String, dynamic>? json) {
    return DogOrigin(
      country: json?['country'] as String? ?? 'Inconnu',
      region: json?['region'] as String? ?? 'Inconnue',
      era: json?['era'] as String? ?? 'Inconnue',
    );
  }
}

class DogCoat {
  final String type;
  final String length;
  final List<String> colors;

  DogCoat({required this.type, required this.length, required this.colors});

  factory DogCoat.fromJson(Map<String, dynamic>? json) {
    return DogCoat(
      type: json?['type'] as String? ?? 'Inconnu',
      length: json?['length'] as String? ?? 'Inconnue',
      colors: (json?['colors'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}

class DogTraits {
  final int energy;
  final int trainability;
  final int barking;
  final int grooming;
  final int shedding;
  final int drooling;
  final int goodWithChildren;
  final int goodWithDogs;
  final int goodWithStrangers;
  final int apartmentFriendly;
  final int exerciseMinutes;
  final List<String> temperament;

  DogTraits({
    required this.energy,
    required this.trainability,
    required this.barking,
    required this.grooming,
    required this.shedding,
    required this.drooling,
    required this.goodWithChildren,
    required this.goodWithDogs,
    required this.goodWithStrangers,
    required this.apartmentFriendly,
    required this.exerciseMinutes,
    required this.temperament,
  });

  factory DogTraits.fromJson(Map<String, dynamic>? json) {
    return DogTraits(
      energy: json?['energy'] as int? ?? 0,
      trainability: json?['trainability'] as int? ?? 0,
      barking: json?['barking'] as int? ?? 0,
      grooming: json?['grooming'] as int? ?? 0,
      shedding: json?['shedding'] as int? ?? 0,
      drooling: json?['drooling'] as int? ?? 0,
      goodWithChildren: json?['good_with_children'] as int? ?? 0,
      goodWithDogs: json?['good_with_dogs'] as int? ?? 0,
      goodWithStrangers: json?['good_with_strangers'] as int? ?? 0,
      apartmentFriendly: json?['apartment_friendly'] as int? ?? 0,
      exerciseMinutes: json?['exercise_minutes'] as int? ?? 0,
      temperament: (json?['temperament'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
    );
  }
}
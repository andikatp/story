import 'package:story/core/utils/typedef.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';

class StoryModel extends StoryEntity {
  const StoryModel({
    required super.id,
    required super.name,
    required super.description,
    required super.photoUrl,
    required super.createdAt,
    required super.lat,
    required super.lon,
  });

  const StoryModel.empty() : super.empty();

  factory StoryModel.fromJson(ResultMap json) {
    return StoryModel(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      photoUrl: json['photoUrl'] as String,
      createdAt: json['createdAt'] as String,
      lat: json['lat'] as double,
      lon: json['lon'] as double,
    );
  }

  ResultMap toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'photoUrl': photoUrl,
      'createdAt': createdAt,
      'lat': lat,
      'lon': lon,
    };
  }
}

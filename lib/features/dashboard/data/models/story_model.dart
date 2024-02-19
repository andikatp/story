import 'package:json_annotation/json_annotation.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';

part 'story_model.g.dart';

@JsonSerializable()
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

  factory StoryModel.fromJson(Map<String, dynamic> json) =>
      _$StoryModelFromJson(json);

  Map<String, dynamic> toJson() => _$StoryModelToJson(this);
}

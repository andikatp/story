import 'package:equatable/equatable.dart';

class StoryEntity extends Equatable {
  const StoryEntity({
    required this.id,
    required this.name,
    required this.description,
    required this.photoUrl,
    required this.createdAt,
    required this.lat,
    required this.lon,
  });

  const StoryEntity.empty()
      : this(
          id: '1',
          name: '',
          description: '',
          photoUrl: '',
          createdAt: '',
          lat: 0,
          lon: 0,
        );

  final String id;
  final String name;
  final String description;
  final String photoUrl;
  final String createdAt;
  final double? lat;
  final double? lon;

  @override
  List<String?> get props => [id];
}

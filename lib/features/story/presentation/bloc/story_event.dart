part of 'story_bloc.dart';

sealed class StoryEvent extends Equatable {
  const StoryEvent();

  @override
  List<Object> get props => [];
}

class AddStoryEvent extends StoryEvent {
  const AddStoryEvent({
    required this.file,
    required this.description,
    required this.lat,
    required this.lon,
  });

  final XFile file;
  final String description;
  final double? lat;
  final double? lon;

  @override
  List<Object> get props => [
        file,
        description,
      ];
}

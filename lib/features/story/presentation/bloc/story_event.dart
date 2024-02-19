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
    required this.location,
  });

  final XFile file;
  final String description;
  final LatLng? location;

  @override
  List<Object> get props => [file, description];
}

class GetLocationEvent extends StoryEvent {
  const GetLocationEvent();
}

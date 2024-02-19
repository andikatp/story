part of 'story_bloc.dart';

sealed class StoryState extends Equatable {
  const StoryState();

  @override
  List<Object> get props => [];
}

final class StoryInitial extends StoryState {
  const StoryInitial();
}

final class StoryLoading extends StoryState {
  const StoryLoading();
}

final class StoryAdded extends StoryState {
  const StoryAdded();
}

final class LocationObtained extends StoryState {
  const LocationObtained({required this.location});
  final Position location;

  @override
  List<Position> get props => [location];
}

final class StoryError extends StoryState {
  const StoryError({required this.message});
  final String message;

  @override
  List<String> get props => [message];
}

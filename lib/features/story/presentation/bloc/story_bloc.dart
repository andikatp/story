import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/features/story/domain/usecases/add_story.dart';
import 'package:story/features/story/domain/usecases/get_position.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc({required AddStory addStory, required GetPosition getPosition})
      : _addStory = addStory,
        _getPosition = getPosition,
        super(const StoryInitial()) {
    on<StoryEvent>((event, emit) {
      emit(const StoryLoading());
    });
    on<AddStoryEvent>(addStoryHandler);
    on<GetLocationEvent>(getLocationHandler);
  }

  final AddStory _addStory;
  final GetPosition _getPosition;

  Future<void> addStoryHandler(
    AddStoryEvent event,
    Emitter<StoryState> emit,
  ) async {
    final result = await _addStory(
      AddStoryParams(
        file: event.file,
        description: event.description,
        location: event.location,
      ),
    );
    result.fold(
      (failure) => emit(StoryError(message: failure.errorMessage)),
      (_) => emit(const StoryAdded()),
    );
  }

  Future<void> getLocationHandler(
    GetLocationEvent event,
    Emitter<StoryState> emit,
  ) async {
    final result = await _getPosition();
    result.fold(
      (failure) => emit(StoryError(message: failure.errorMessage)),
      (location) => emit(LocationObtained(location: location)),
    );
  }
}

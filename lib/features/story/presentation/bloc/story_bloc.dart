import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/features/story/domain/usecases/add_story.dart';

part 'story_event.dart';
part 'story_state.dart';

class StoryBloc extends Bloc<StoryEvent, StoryState> {
  StoryBloc({required AddStory addStory})
      : _addStory = addStory,
        super(const StoryInitial()) {
    on<StoryEvent>((event, emit) {
      emit(const StoryLoading());
    });
    on<AddStoryEvent>(addStoryHandler);
  }

  final AddStory _addStory;

  Future<void> addStoryHandler(
    AddStoryEvent event,
    Emitter<StoryState> emit,
  ) async {
    final result = await _addStory(
      AddStoryParams(
        file: event.file,
        description: event.description,
        isLocationAdded: event.isLocationAdded,
      ),
    );
    result.fold(
      (failure) => emit(StoryError(message: failure.errorMessage)),
      (_) => emit(const StoryAdded()),
    );
  }
}

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/story/domain/repositories/story_repository.dart';

class AddStory implements UseCaseWithParams<void, AddStoryParams> {
  AddStory({required StoryRepository repository}) : _repository = repository;
  final StoryRepository _repository;

  @override
  ResultFuture<void> call(AddStoryParams params) => _repository.addStory(
        file: params.file,
        description: params.description,
        location: params.location,
      );
}

class AddStoryParams {
  AddStoryParams({
    required this.file,
    required this.description,
    required this.location,
  });

  AddStoryParams.empty()
      : this(file: XFile(''), description: '', location: const LatLng(0, 0));

  final XFile file;
  final String description;
  final LatLng? location;
}

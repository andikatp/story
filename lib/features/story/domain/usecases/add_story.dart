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
        isLocationAdded: params.isLocationAdded,
      );
}

class AddStoryParams {
  AddStoryParams({
    required this.isLocationAdded,
    required this.file,
    required this.description,
  });

  AddStoryParams.empty()
      : this(isLocationAdded: false, file: XFile(''), description: '');

  final XFile file;
  final String description;
  final bool isLocationAdded;
}

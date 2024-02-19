import 'package:geolocator/geolocator.dart';
import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/story/domain/repositories/story_repository.dart';

class GetPosition implements UseCaseWithoutParams<Position> {
  GetPosition({required StoryRepository repository}) : _repository = repository;
  final StoryRepository _repository;

  @override
  ResultFuture<Position> call() => _repository.getPosition();
}

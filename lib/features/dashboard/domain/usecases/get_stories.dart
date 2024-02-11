import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';
import 'package:story/features/dashboard/domain/repositories/dashboard_repository.dart';

class GetStories implements UseCaseWithoutParams<List<StoryEntity>> {
  GetStories({required DashboardRepository repository})
      : _repository = repository;
  final DashboardRepository _repository;

  @override
  ResultFuture<List<StoryEntity>> call() => _repository.getStories();
}

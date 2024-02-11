import 'package:story/core/utils/typedef.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';

abstract class DashboardRepository {
  const DashboardRepository();

  ResultFuture<List<StoryEntity>> getStories();
}

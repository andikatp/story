import 'package:image_picker/image_picker.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';

abstract class DashboardRepository {
  const DashboardRepository();

  ResultFuture<List<StoryEntity>> getStories({required int page});

  ResultFuture<void> addStory({
    required XFile file,
    required String description,
    double lat,
    double lon,
  });
}

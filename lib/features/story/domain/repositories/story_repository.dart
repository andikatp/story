import 'package:geolocator/geolocator.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/core/utils/typedef.dart';

abstract class StoryRepository {
  const StoryRepository();

  ResultFuture<void> addStory({
    required XFile file,
    required String description,
    required bool isLocationAdded,
  });

  ResultFuture<Position> getPosition();
}

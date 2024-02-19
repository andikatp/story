import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/core/utils/typedef.dart';

abstract class StoryRepository {
  const StoryRepository();

  ResultFuture<void> addStory({
    required XFile file,
    required String description,
    required LatLng? location,
  });

  ResultFuture<Position> getPosition();
}

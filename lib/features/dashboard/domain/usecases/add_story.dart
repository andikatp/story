import 'package:image_picker/image_picker.dart';
import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/dashboard/domain/repositories/dashboard_repository.dart';

class AddStory implements UseCaseWithParams<void, AddStoryParams> {
  AddStory({required DashboardRepository repository})
      : _repository = repository;
  final DashboardRepository _repository;

  @override
  ResultFuture<void> call(AddStoryParams params) => _repository.addStory(
        file: params.file,
        description: params.description,
        lat: params.lat,
        lon: params.lon,
      );
}

class AddStoryParams {
  AddStoryParams(
    this.lat,
    this.lon, {
    required this.file,
    required this.description,
  });

  final XFile file;
  final String description;
  final double lat;
  final double lon;
}

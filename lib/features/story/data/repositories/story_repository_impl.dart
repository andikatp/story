import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/core/services/network_info.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/story/data/datasources/story_remote_data_source.dart';
import 'package:story/features/story/domain/repositories/story_repository.dart';

class StoryRepositoryImpl implements StoryRepository {
  StoryRepositoryImpl({
    required NetworkInfo networkInfo,
    required StoryRemoteDataSource dataSource,
  })  : _networkInfo = networkInfo,
        _dataSource = dataSource;

  final NetworkInfo _networkInfo;
  final StoryRemoteDataSource _dataSource;

  @override
  ResultFuture<void> addStory({
    required XFile file,
    required String description,
    double? lat,
    double? lon,
  }) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result =
          await _dataSource.addStory(file: file, description: description);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }
}

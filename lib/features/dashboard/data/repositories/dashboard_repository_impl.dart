import 'package:dartz/dartz.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/core/services/network_info.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/dashboard/data/datasources/dashboard_remote_datasource.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';
import 'package:story/features/dashboard/domain/repositories/dashboard_repository.dart';

class DashboardRepositoryImpl implements DashboardRepository {
  DashboardRepositoryImpl({
    required NetworkInfo networkInfo,
    required DashboardRemoteDataSource dataSource,
  })  : _networkInfo = networkInfo,
        _dataSource = dataSource;

  final NetworkInfo _networkInfo;
  final DashboardRemoteDataSource _dataSource;

  @override
  ResultFuture<List<StoryEntity>> getStories({required int page}) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _dataSource.getStories(page: page);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

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

import 'package:dartz/dartz.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/splash_screen/data/datasources/splash_screen_local_datasource.dart';
import 'package:story/features/splash_screen/domain/repositories/splash_screen_repository.dart';

class SplashScreenRepositoryImpl implements SplashScreenRepository {
  SplashScreenRepositoryImpl({
    required SplashScreenLocalDataSource localDataSource,
  }) : _localDataSource = localDataSource;

  final SplashScreenLocalDataSource _localDataSource;

  @override
  ResultFuture<bool> checkUserLoggedIn() async {
    try {
      final result = await _localDataSource.isUserLoggedIn();
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}

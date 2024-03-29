import 'package:dartz/dartz.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/core/services/network_info.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/auth/data/datasource/auth_local_datasource.dart';
import 'package:story/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:story/features/auth/data/model/user_model.dart';
import 'package:story/features/auth/domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remoteDataSource,
    required AuthLocalDataSource localDataSource,
    required NetworkInfo networkInfo,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource,
        _networkInfo = networkInfo;
  final AuthRemoteDataSource _remoteDataSource;
  final AuthLocalDataSource _localDataSource;
  final NetworkInfo _networkInfo;

  @override
  ResultFuture<UserModel> login({
    required String email,
    required String password,
  }) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result =
          await _remoteDataSource.login(email: email, password: password);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    try {
      if (!await _networkInfo.isConnected) {
        return const Left(InternetFailure());
      }
      final result = await _remoteDataSource.register(
        name: name,
        email: email,
        password: password,
      );
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure.fromException(e));
    }
  }

  @override
  ResultFuture<void> saveToken({required String token}) async {
    try {
      final result = await _localDataSource.saveToken(token);
      return Right(result);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/profile/data/data/profile_local_datasource.dart';
import 'package:story/features/profile/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  ProfileRepositoryImpl({required ProfileLocalDataSource localData})
      : _localData = localData;
  final ProfileLocalDataSource _localData;

  @override
  ResultFuture<void> logout() async {
    try {
      await _localData.logout();
      return const Right(null);
    } on CacheException catch (e) {
      return Left(CacheFailure.fromException(e));
    }
  }
}

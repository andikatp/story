import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/profile/data/data/profile_local_datasource.dart';
import 'package:story/features/profile/data/repositories/profile_repository_impl.dart';

class MockProfileLocalDataSource extends Mock
    implements ProfileLocalDataSource {}

void main() {
  late ProfileLocalDataSource mockLocalDataSource;
  late ProfileRepositoryImpl repository;

  setUp(() {
    mockLocalDataSource = MockProfileLocalDataSource();
    repository = ProfileRepositoryImpl(localData: mockLocalDataSource);
  });

  group('localDataSource', () {
    const tException = CacheException(message: 'message');
    test(
        'Should remove the token successfully when '
        'SharedPreferences.remove called ', () async {
      // arrange
      when(() => mockLocalDataSource.logout())
          .thenAnswer((_) async => Future.value());
      // act
      final result = await repository.logout();
      // assert
      expect(result, const Right<dynamic, void>(null));
      verify(() => mockLocalDataSource.logout()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });

    test(
        'Should Failed remove the token when '
        'SharedPreferences.remove called ', () async {
      // arrange
      when(() => mockLocalDataSource.logout()).thenThrow(tException);
      // act
      final result = await repository.logout();
      // assert
      expect(
        result,
        Left<Failure, dynamic>(CacheFailure.fromException(tException)),
      );
      verify(() => mockLocalDataSource.logout()).called(1);
      verifyNoMoreInteractions(mockLocalDataSource);
    });
  });
}

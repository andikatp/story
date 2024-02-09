import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/splash/data/datasources/splash_local_datasource.dart';
import 'package:story/features/splash/data/repositories/splash_repository_impl.dart';
import 'package:story/features/splash/domain/repositories/splash_repository.dart';

class MockSplashLocalDataSource extends Mock implements SplashLocalDataSource {}

void main() {
  late SplashLocalDataSource mockLocalDataSource;
  late SplashRepository repository;

  setUp(() {
    mockLocalDataSource = MockSplashLocalDataSource();
    repository = SplashRepositoryImpl(localDataSource: mockLocalDataSource);
  });

  group('localDataSource', () {
    const tException = CacheException(message: 'message');
    test(
        'Should get the token successfully when '
        'SharedPreferences fetch the token', () async {
      // arrange
      when(() => mockLocalDataSource.isUserLoggedIn())
          .thenAnswer((_) async => true);
      // act
      final result = await repository.checkUserLoggedIn();
      // assert
      expect(result, equals(const Right<dynamic, bool>(true)));
    });

    test(
        'Should throw a [CacheException] '
        'when the failed to fetch token', () async {
      // arrange
      when(() => mockLocalDataSource.isUserLoggedIn()).thenThrow(tException);
      // act
      final result = await repository.checkUserLoggedIn();
      // assert
      expect(
        result,
        equals(
          Left<Failure, dynamic>(CacheFailure.fromException(tException)),
        ),
      );
    });
  });
}

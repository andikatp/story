import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/splash/domain/repositories/splash_repository.dart';
import 'package:story/features/splash/domain/usecases/check_user_logged_in.dart';

class MockSplashRepository extends Mock implements SplashRepository {}

void main() {
  late CheckUserLoggedIn usecase;
  late SplashRepository mockRepository;

  setUp(() {
    mockRepository = MockSplashRepository();
    usecase = CheckUserLoggedIn(repository: mockRepository);
  });

  group('checkUserLoggedIn', () {
    const tFailure = CacheFailure(message: 'message');
    test(
        'Should call [SplashRepository.checkUserLoggedIn] '
        'and return a right value', () async {
      // arrange
      when(() => mockRepository.checkUserLoggedIn())
          .thenAnswer((_) async => const Right(true));
      // act
      final result = await usecase();
      // assert
      expect(result, equals(const Right<dynamic, bool>(true)));
      verify(() => mockRepository.checkUserLoggedIn()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
        'Should call [AuthRepository.register] '
        'and return a [CacheFailure]', () async {
      // arrange
      when(() => mockRepository.checkUserLoggedIn())
          .thenAnswer((_) async => const Left(tFailure));
      // act
      final result = await usecase();
      // assert
      expect(result, equals(const Left<Failure, dynamic>(tFailure)));
      verify(() => mockRepository.checkUserLoggedIn()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

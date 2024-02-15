import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/profile/domain/repositories/profile_repository.dart';
import 'package:story/features/profile/domain/usecases/logout.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

void main() {
  late Logout logout;
  late ProfileRepository mockRepository;

  setUp(() {
    mockRepository = MockProfileRepository();
    logout = Logout(repository: mockRepository);
  });

  group('logOut', () {
    test(
        'Should call [ProfileRepository.logout] '
        'and return a right value', () async {
      // arrange
      when(() => mockRepository.logout())
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await logout();
      // assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
        'Should call [ProfileRepository.logout] '
        'and return a left value', () async {
      // arrange
      when(() => mockRepository.logout()).thenAnswer(
        (_) async => const Left(CacheFailure(message: 'message')),
      );
      // act
      final result = await logout();

      // assert
      expect(
        result,
        equals(
          const Left<Failure, dynamic>(CacheFailure(message: 'message')),
        ),
      );
      verify(() => mockRepository.logout()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

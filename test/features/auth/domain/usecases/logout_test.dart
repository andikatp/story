import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/auth/domain/repositories/auth_repository.dart';
import 'package:story/features/auth/domain/usecases/logout.dart';

import 'auth_repository_mock.dart';

void main() {
  late AuthRepository mockRepository;
  late Logout usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = Logout(repository: mockRepository);
  });

  group('logOut', () {
    const tServerFailure = ServerFailure(message: '');

    test(
        'Should call [AuthRepository.logout] '
        'and return a right data', () async {
      // arrange
      when(() => mockRepository.logout()).thenAnswer((_) async => right(null));
      // act
      final result = await usecase();
      // assert
      expect(result, equals(right<dynamic, void>(null)));
      verify(() => mockRepository.logout());
      verifyNoMoreInteractions(mockRepository);
    });

    test(
        'Should call [AuthRepository.logout] '
        'and return [ServerFailure]', () async {
      // arrange
      when(() => mockRepository.logout())
          .thenAnswer((_) async => left(tServerFailure));
      // act
      final result = await usecase();
      // assert
      expect(result, equals(left<Failure, dynamic>(tServerFailure)));
      verify(() => mockRepository.logout());
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

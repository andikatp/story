import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/auth/domain/repositories/auth_repository.dart';
import 'package:story/features/auth/domain/usecases/save_token.dart';

import 'auth_repository_mock.dart';

void main() {
  late AuthRepository mockRepository;
  late SaveToken usecases;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecases = SaveToken(repository: mockRepository);
  });

  group('saveToken', () {
    const fToken = 'token_test';
    const tFailure = CacheFailure(message: '');
    test(
        'Should call [AuthRepository.saveToken] '
        'and return a void', () async {
      // arrange
      when(() => mockRepository.saveToken(token: any(named: 'token')))
          .thenAnswer((_) async => const Right(null));
      // act
      final result = await usecases(fToken);
      // assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(() => mockRepository.saveToken(token: fToken)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test(
        'Should call [AuthRepository.saveToken] '
        'and return a [CacheFailure]', () async {
      // arrange
      when(() => mockRepository.saveToken(token: any(named: 'token')))
          .thenAnswer((_) async => const Left(tFailure));
      // act
      final result = await usecases(fToken);
      // assert
      expect(result, equals(const Left<Failure, dynamic>(tFailure)));
      verify(() => mockRepository.saveToken(token: fToken)).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

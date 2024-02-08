import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/auth/domain/entity/user.dart';
import 'package:story/features/auth/domain/repositories/auth_repository.dart';
import 'package:story/features/auth/domain/usecases/login.dart';

import 'auth_repository_mock.dart';

void main() {
  late AuthRepository mockRepository;
  late Login usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = Login(repository: mockRepository);
  });

  group('login', () {
    const tParams = LoginParams.empty();
    const tUser = UserEntity.empty();
    const tServerFailure = ServerFailure(message: 'message');

    test(
        'Should call [AuthRepository.login] '
        'and return [UserEntity]', () async {
      // arrange
      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(tUser));
      // act
      final result = await usecase(tParams);
      // assert
      expect(result, equals(right<dynamic, UserEntity>(tUser)));
      verify(
        () => mockRepository.login(
          email: tParams.email,
          password: tParams.password,
        ),
      );
      verifyNoMoreInteractions(mockRepository);
    });

    test(
        'Should call [AuthRepository.login] '
        'and return [ServerFailure]', () async {
      // arrange
      when(
        () => mockRepository.login(
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result = await usecase(tParams);
      // assert
      expect(result, equals(left<Failure, dynamic>(tServerFailure)));
      verify(
        () => mockRepository.login(
          email: tParams.email,
          password: tParams.password,
        ),
      );
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

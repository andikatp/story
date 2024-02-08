import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/auth/domain/repositories/auth_repository.dart';
import 'package:story/features/auth/domain/usecases/register.dart';
import 'auth_repository_mock.dart';

void main() {
  late AuthRepository mockRepository;
  late Register usecase;

  setUp(() {
    mockRepository = MockAuthRepository();
    usecase = Register(repository: mockRepository);
  });

  group('register', () {
    const tServerFailure = ServerFailure(message: 'message');
    const tParams = RegisterParams.empty();

    test(
        'Should call [AuthRepository.register] '
        'and return a void', () async {
      // arrange
      when(
        () => mockRepository.register(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Right(null));
      // act
      final result = await usecase(tParams);
      // assert
      expect(result, equals(const Right<dynamic, void>(null)));
      verify(
        () => mockRepository.register(
          name: tParams.name,
          email: tParams.email,
          password: tParams.password,
        ),
      );
      verifyNoMoreInteractions(mockRepository);
    });

    test(
        'Should call [AuthRepository.register] '
        'and return a [ServerFailure]', () async {
      // arrange
      when(
        () => mockRepository.register(
          name: any(named: 'name'),
          email: any(named: 'email'),
          password: any(named: 'password'),
        ),
      ).thenAnswer((_) async => const Left(tServerFailure));
      // act
      final result = await usecase(tParams);
      // assert
      expect(result, equals(const Left<Failure, dynamic>(tServerFailure)));
      verify(
        () => mockRepository.register(
          name: tParams.name,
          email: tParams.email,
          password: tParams.password,
        ),
      );
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/core/services/network_info.dart';
import 'package:story/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:story/features/auth/data/model/user_model.dart';
import 'package:story/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:story/features/auth/domain/usecases/login.dart';
import 'package:story/features/auth/domain/usecases/register.dart';

class MockAuthRemoteDataSourceImpl extends Mock
    implements AuthRemoteDataSourceImpl {}

class MockNetworkInfoImpl extends Mock implements NetworkInfoImpl {}

void main() {
  late AuthRemoteDataSource mockRemoteDataSource;
  late NetworkInfoImpl mockNetworkInfo;
  late AuthRepositoryImpl repository;

  setUp(() {
    mockRemoteDataSource = MockAuthRemoteDataSourceImpl();
    mockNetworkInfo = MockNetworkInfoImpl();
    repository = AuthRepositoryImpl(
      remoteDataSource: mockRemoteDataSource,
      networkInfo: mockNetworkInfo,
    );
  });

  const tUserParams = RegisterParams.empty();

  test('Should check if the device is online', () async {
    // arrange
    when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => false);
    // act
    await repository.register(
      name: tUserParams.name,
      email: tUserParams.email,
      password: tUserParams.password,
    );
    // assert
    expect(false, await mockNetworkInfo.isConnected);
  });

  group('remote', () {
    const tException = ServerException(message: 'message');

    setUp(
      () =>
          when(() => mockNetworkInfo.isConnected).thenAnswer((_) async => true),
    );

    group('Register', () {
      const tRegisterParams = RegisterParams.empty();
      test(
          'Should call [MockAuthRemoteDataSourceImpl.register] '
          'and return a Right data', () async {
        // arrange
        when(
          () => mockRemoteDataSource.register(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => Future.value());
        // act
        final result = await repository.register(
          name: tRegisterParams.name,
          email: tRegisterParams.email,
          password: tRegisterParams.password,
        );
        // assert
        expect(result, equals(const Right<dynamic, void>(null)));
        verify(
          () => mockRemoteDataSource.register(
            name: tRegisterParams.name,
            email: tRegisterParams.email,
            password: tRegisterParams.password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      });

      test(
          'Should call [MockAuthRemoteDataSourceImpl.register] '
          'and return a Server Failure when failed', () async {
        // arrange
        when(
          () => mockRemoteDataSource.register(
            name: any(named: 'name'),
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tException);
        // act
        final result = await repository.register(
          name: tRegisterParams.name,
          email: tRegisterParams.email,
          password: tRegisterParams.password,
        );
        // assert
        expect(
          result,
          equals(
            Left<Failure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );
      });
    });

    group('login', () {
      const tLoginParams = LoginParams.empty();
      const tUser = UserModel.empty();
      test(
          'Should call [MockAuthRemoteDataSourceImpl.login] '
          'and return a [UserModel] data', () async {
        // arrange
        when(
          () => mockRemoteDataSource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenAnswer((_) async => tUser);
        // act
        final result = await repository.login(
          email: tLoginParams.email,
          password: tLoginParams.password,
        );
        // assert
        expect(result, equals(const Right<dynamic, UserModel>(tUser)));
        verify(
          () => mockRemoteDataSource.login(
            email: tLoginParams.email,
            password: tLoginParams.password,
          ),
        ).called(1);
        verifyNoMoreInteractions(mockRemoteDataSource);
      });
      test(
          'Should call [MockAuthRemoteDataSourceImpl.login] '
          'and return a Server Failure when failed', () async {
        // arrange
        when(
          () => mockRemoteDataSource.login(
            email: any(named: 'email'),
            password: any(named: 'password'),
          ),
        ).thenThrow(tException);
        // act
        final result = await repository.login(
          email: tLoginParams.email,
          password: tLoginParams.password,
        );
        // assert
        expect(
          result,
          equals(
            Left<Failure, dynamic>(
              ServerFailure.fromException(tException),
            ),
          ),
        );
      });
    });
  });
}

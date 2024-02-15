import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/features/auth/domain/entity/user_entity.dart';
import 'package:story/features/auth/domain/usecases/login.dart';
import 'package:story/features/auth/domain/usecases/register.dart';
import 'package:story/features/auth/domain/usecases/save_token.dart';
import 'package:story/features/auth/presentation/bloc/auth_bloc.dart';

class MockLogin extends Mock implements Login {}

class MockRegister extends Mock implements Register {}

class MockSaveToken extends Mock implements SaveToken {}

void main() {
  late AuthBloc bloc;
  late Register mockRegister;
  late Login mockLogin;
  late SaveToken mockSaveToken;

  setUp(() {
    mockRegister = MockRegister();
    mockLogin = MockLogin();
    mockSaveToken = MockSaveToken();
    bloc = AuthBloc(
      login: mockLogin,
      register: mockRegister,
      saveToken: mockSaveToken,
    );
    registerFallbackValue(const LoginParams.empty());
    registerFallbackValue(const RegisterParams.empty());
  });

  test('Should get [AuthInitial] as initial state', () async {
    // assert
    expect(bloc.state, const AuthInitial());
  });

  const tLoginParams = LoginParams.empty();
  const tRegisterParams = RegisterParams.empty();
  const tUser = UserEntity.empty();
  blocTest<AuthBloc, AuthState>(
    'Should emit [AuthLoading] and [LoggedIn] '
    'when data is gotten successfully',
    build: () {
      when(() => mockLogin(any())).thenAnswer((_) async => const Right(tUser));
      return bloc;
    },
    act: (bloc) => bloc.add(
      LoginEvent(email: tLoginParams.email, password: tLoginParams.password),
    ),
    expect: () => [
      const AuthLoading(),
      const LoggedIn(user: tUser),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'Should emit [AuthLoading] and [Registered] '
    'when data is gotten successfully',
    build: () {
      when(() => mockRegister(any()))
          .thenAnswer((_) async => const Right(null));
      return bloc;
    },
    act: (bloc) => bloc.add(
      RegisterEvent(
        name: tRegisterParams.name,
        email: tRegisterParams.email,
        password: tRegisterParams.password,
      ),
    ),
    expect: () => [
      const AuthLoading(),
      const Registered(),
    ],
  );

  blocTest<AuthBloc, AuthState>(
    'Should emit [AuthLoading] and [TokenSaved] '
    'when data is gotten successfully',
    build: () {
      when(() => mockSaveToken(any()))
          .thenAnswer((_) async => const Right(null));
      return bloc;
    },
    act: (bloc) => bloc.add(
      const SaveTokenEvent(token: ''),
    ),
    expect: () => [
      const AuthLoading(),
      const TokenSaved(),
    ],
  );
}

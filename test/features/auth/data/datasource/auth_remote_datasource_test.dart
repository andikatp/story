import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mocktail/mocktail.dart';
import 'package:story/core/constants/api_endpoint.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/features/auth/data/datasource/auth_remote_datasource.dart';
import 'package:story/features/auth/data/model/user_model.dart';
import 'package:story/features/auth/domain/usecases/login.dart';
import 'package:story/features/auth/domain/usecases/register.dart';

class MockHttpClient extends Mock implements http.Client {}

void main() {
  late http.Client mockHttpClient;
  late AuthRemoteDataSource remote;

  setUp(() {
    mockHttpClient = MockHttpClient();
    remote = AuthRemoteDataSourceImpl(client: mockHttpClient);
    registerFallbackValue(Uri());
  });

  group('register', () {
    const tRegisterParams = RegisterParams.empty();

    test('Should complete successfully when no [Exception] is thrown',
        () async {
      // arrange
      when(
        () => mockHttpClient.post(
          any(that: isA<Uri>()),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async =>
            http.Response('{"error": "false", "message": "User Created"}', 201),
      );
      // act and assert
      await expectLater(
        remote.register(
          name: tRegisterParams.name,
          email: tRegisterParams.email,
          password: tRegisterParams.password,
        ),
        completes,
      );
      // assert
      verify(
        () => mockHttpClient.post(
          Uri.parse('${AppConstant.baseUrl}${ApiEndpoint.register}'),
          body: jsonEncode(
            {
              'name': tRegisterParams.name,
              'email': tRegisterParams.email,
              'password': tRegisterParams.password,
            },
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('Should throw a server exception when the response code is not 201',
        () async {
      // arrange
      when(
        () => mockHttpClient.post(
          any(that: isA<Uri>()),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"error": true, "message": "Something went wrong"}',
          400,
        ),
      );
      // act
      final methodCall = remote.register;
      // assert
      expect(
        methodCall(
          name: tRegisterParams.name,
          email: tRegisterParams.email,
          password: tRegisterParams.password,
        ),
        throwsA(const ServerException(message: 'Something went wrong')),
      );
    });
  });

  group('login', () {
    const tLoginParams = LoginParams.empty();
    test('Should complete successfully when no [Exception] is thrown',
        () async {
      // arrange
      when(
        () => mockHttpClient.post(
          any(that: isA<Uri>()),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"error": "false", "message": "success", "loginResult": {"userId": '
          '"user-yj5pc_LARC_AgK61","name": "Andika Tri Prasetya","token": '
          '"abs21"}}',
          201,
        ),
      );
      // act
      final result = await remote.login(
        email: tLoginParams.email,
        password: tLoginParams.password,
      );
      // assert
      expect(result, isA<UserModel>());
      verify(
        () => mockHttpClient.post(
          Uri.parse('${AppConstant.baseUrl}${ApiEndpoint.login}'),
          body: jsonEncode(
            {
              'email': tLoginParams.email,
              'password': tLoginParams.password,
            },
          ),
        ),
      ).called(1);
      verifyNoMoreInteractions(mockHttpClient);
    });

    test('Should throw a server exception when the response code is not 201',
        () async {
      when(
        () => mockHttpClient.post(
          any(that: isA<Uri>()),
          body: any(named: 'body'),
        ),
      ).thenAnswer(
        (_) async => http.Response(
          '{"error": true, "message": "Something went wrong"}',
          400,
        ),
      );
      // act
      final methodCall = remote.login;
      // assert
      expect(
        methodCall(
          email: tLoginParams.email,
          password: tLoginParams.password,
        ),
        throwsA(const ServerException(message: 'Something went wrong')),
      );
    });
  });
}

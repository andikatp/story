import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:story/core/constants/api_endpoint.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/errors/exceptions.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  /// Registers a new user with the provided [name], [email], and [password].
  ///
  /// Calls the post request to https://story-api.dicoding.dev/v1/register/ endpoint.
  ///
  /// Throws a [ServerException] for all the error codes.
  Future<void> register({
    required String name,
    required String email,
    required String password,
  });

  /// Logs in a user with the provided [email] and [password].
  ///
  /// Calls the post request https://story-api.dicoding.dev/v1/login/ endpoint.
  ///
  /// Throws a [ServerException] for all the error codes.
  ///
  /// Returns a [UserModel] representing the logged-in user.
  Future<UserModel> login({required String email, required String password});
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  AuthRemoteDataSourceImpl({required http.Client client}) : _client = client;

  final http.Client _client;

  @override
  Future<UserModel> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${AppConstant.baseUrl}${ApiEndpoint.login}');
    final response = await _client.post(
      url,
      body: {
        'email': email,
        'password': password,
      },
    );
    final decode = jsonDecode(response.body) as ResultMap;
    if (response.statusCode != AppConstant.successfulHttpPostStatusCode) {
      throw ServerException(message: decode['message'] as String);
    }
    return UserModel.fromJson(decode['loginResult'] as ResultMap);
  }

  @override
  Future<void> register({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('${AppConstant.baseUrl}${ApiEndpoint.register}');
    final response = await _client.post(
      url,
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
    final decode = jsonDecode(response.body) as ResultMap;
    if (response.statusCode != AppConstant.successfulHttpPostStatusCode) {
      throw ServerException(
        message: decode['message'] as String,
      );
    }
  }
}

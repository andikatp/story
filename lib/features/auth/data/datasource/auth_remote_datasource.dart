import 'package:story/features/auth/data/model/user_model.dart';

abstract class AuthRemoteDataSource {
  const AuthRemoteDataSource();

  Future<void> register({
    required String name,
    required String email,
    required String password,
  });
  Future<UserModel> login({required String email, required String password});
  Future<void> logout();
}

class AuthRemoteDataSourceImpl extends AuthRemoteDataSource {
  @override
  Future<UserModel> login({required String email, required String password}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<void> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<void> register(
      {required String name, required String email, required String password,}) {
    // TODO: implement register
    throw UnimplementedError();
  }
}

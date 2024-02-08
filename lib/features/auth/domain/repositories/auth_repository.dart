import 'package:story/core/utils/typedef.dart';
import 'package:story/features/auth/domain/entity/user_entity.dart';

abstract class AuthRepository {
  const AuthRepository();

  ResultFuture<void> register({
    required String name,
    required String email,
    required String password,
  });

  ResultFuture<UserEntity> login({
    required String email,
    required String password,
  });
}

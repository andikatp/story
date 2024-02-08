import 'package:equatable/equatable.dart';
import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/auth/domain/entity/user_entity.dart';
import 'package:story/features/auth/domain/repositories/auth_repository.dart';

class Login implements UseCaseWithParams<UserEntity, LoginParams> {
  Login({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  @override
  ResultFuture<UserEntity> call(LoginParams params) =>
      _repository.login(email: params.email, password: params.password);
}

class LoginParams extends Equatable {
  const LoginParams({required this.email, required this.password});

  const LoginParams.empty() : this(email: '', password: '');

  final String email;
  final String password;

  @override
  List<String?> get props => [email, password];
}

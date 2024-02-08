import 'package:equatable/equatable.dart';
import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/auth/domain/repositories/auth_repository.dart';

class Register implements UseCaseWithParams<void, RegisterParams> {
  Register({required AuthRepository repository}) : _repository = repository;
  final AuthRepository _repository;

  @override
  ResultFuture<void> call(RegisterParams params) => _repository.register(
        name: params.name,
        email: params.email,
        password: params.password,
      );
}

class RegisterParams extends Equatable {
  const RegisterParams({
    required this.name,
    required this.email,
    required this.password,
  });

  const RegisterParams.empty() : this(name: '', email: '', password: '');

  final String name;
  final String email;
  final String password;

  @override
  List<String?> get props => [name, email, password];
}

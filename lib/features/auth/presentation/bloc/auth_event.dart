part of 'auth_bloc.dart';

sealed class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  const LoginEvent({required this.email, required this.password});

  final String email;
  final String password;

  @override
  List<String> get props => [email, password];
}

class RegisterEvent extends AuthEvent {
  const RegisterEvent({
    required this.name,
    required this.email,
    required this.password,
  });

  final String name;
  final String email;
  final String password;

  @override
  List<String> get props => [name, email, password];
}

class SaveTokenEvent extends AuthEvent {
  const SaveTokenEvent({required this.token});
  final String token;

  @override
  List<String> get props => [token];
}

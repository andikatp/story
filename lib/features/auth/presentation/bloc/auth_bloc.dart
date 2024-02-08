import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story/features/auth/domain/entity/user_entity.dart';
import 'package:story/features/auth/domain/usecases/login.dart';
import 'package:story/features/auth/domain/usecases/register.dart';
import 'package:story/features/auth/domain/usecases/save_token.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc({
    required Login login,
    required Register register,
    required SaveToken saveToken,
  })  : _login = login,
        _register = register,
        _saveToken = saveToken,
        super(const AuthInitial()) {
    on<AuthEvent>((event, emit) => emit(const AuthLoading()));
    on<RegisterEvent>(_registerHandler);
    on<LoginEvent>(_loginHandler);
    on<SaveTokenEvent>(_saveTokenHandler);
  }

  final Login _login;
  final Register _register;
  final SaveToken _saveToken;

  Future<void> _registerHandler(
    RegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _register(
      RegisterParams(
        name: event.name,
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (_) => emit(const Registered()),
    );
  }

  Future<void> _loginHandler(
    LoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _login(
      LoginParams(
        email: event.email,
        password: event.password,
      ),
    );
    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (user) => emit(LoggedIn(user: user)),
    );
  }

  Future<void> _saveTokenHandler(
    SaveTokenEvent event,
    Emitter<AuthState> emit,
  ) async {
    final result = await _saveToken(event.token);
    result.fold(
      (failure) => emit(AuthError(message: failure.errorMessage)),
      (_) => emit(const TokenSaved()),
    );
  }
}

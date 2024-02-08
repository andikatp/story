part of 'splash_cubit.dart';

sealed class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

final class SplashInitial extends SplashState {
  const SplashInitial();
}

final class SplashLoading extends SplashState {
  const SplashLoading();
}

final class SplashUserChecked extends SplashState {
  const SplashUserChecked({required this.isUserLoggedIn});
  final bool isUserLoggedIn;

  @override
  List<Object> get props => [isUserLoggedIn];
}

final class SplashError extends SplashState {
  const SplashError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

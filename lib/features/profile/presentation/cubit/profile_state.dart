part of 'profile_cubit.dart';

sealed class ProfileState extends Equatable {
  const ProfileState();

  @override
  List<Object> get props => [];
}

final class ProfileInitial extends ProfileState {
  const ProfileInitial();
}

final class ProfileLoading extends ProfileState {
  const ProfileLoading();
}

final class LoggedOut extends ProfileState {
  const LoggedOut();
}

final class ProfileError extends ProfileState {
  const ProfileError({required this.message});

  final String message;

  @override
  List<String> get props => [message];
}

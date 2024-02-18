import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story/features/profile/domain/usecases/logout.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit({required Logout logout})
      : _logout = logout,
        super(const ProfileInitial());

  final Logout _logout;

  Future<void> logout() async {
    emit(const ProfileLoading());
    final result = await _logout();
    result.fold(
      (failure) => emit(ProfileError(message: failure.errorMessage)),
      (_) => emit(const LoggedOut()),
    );
  }
  
}

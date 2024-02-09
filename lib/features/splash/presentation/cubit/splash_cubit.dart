import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story/features/splash/domain/usecases/check_user_logged_in.dart';

part 'splash_state.dart';

class SplashCubit extends Cubit<SplashState> {
  SplashCubit({required CheckUserLoggedIn checkUserLoggedIn})
      : _checkUserLoggedIn = checkUserLoggedIn,
        super(const SplashInitial());

  final CheckUserLoggedIn _checkUserLoggedIn;

  Future<void> checkUserLoggedIn() async {
    emit(const SplashLoading());
    final result = await _checkUserLoggedIn();
    result.fold(
      (failure) => emit(SplashError(message: failure.errorMessage)),
      (isUserLoggedIn) =>
          emit(SplashUserChecked(isUserLoggedIn: isUserLoggedIn)),
    );
  }
}

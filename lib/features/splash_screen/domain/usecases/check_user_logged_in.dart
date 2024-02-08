import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/splash_screen/domain/repositories/splash_screen_repository.dart';

class CheckUserLoggedIn implements UseCaseWithoutParams<bool> {
  CheckUserLoggedIn({required SplashScreenRepository repository})
      : _repository = repository;

  final SplashScreenRepository _repository;

  @override
  ResultFuture<bool> call() => _repository.checkUserLoggedIn();
}

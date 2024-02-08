import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/splash_screen/domain/repositories/splash_repository.dart';

class CheckUserLoggedIn implements UseCaseWithoutParams<bool> {
  CheckUserLoggedIn({required SplashRepository repository})
      : _repository = repository;

  final SplashRepository _repository;

  @override
  ResultFuture<bool> call() => _repository.checkUserLoggedIn();
}

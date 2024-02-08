import 'package:story/core/utils/typedef.dart';

abstract class SplashScreenRepository {
  const SplashScreenRepository();

  ResultFuture<bool> checkUserLoggedIn();
}

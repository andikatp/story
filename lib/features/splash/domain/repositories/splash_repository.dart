import 'package:story/core/utils/typedef.dart';

abstract class SplashRepository {
  const SplashRepository();

  ResultFuture<bool> checkUserLoggedIn();
}

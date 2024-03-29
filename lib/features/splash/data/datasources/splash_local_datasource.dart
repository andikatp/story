import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/errors/exceptions.dart';

abstract class SplashLocalDataSource {
  const SplashLocalDataSource();

  Future<bool> isUserLoggedIn();
}

class SplashLocalDataSourceImpl implements SplashLocalDataSource {
  SplashLocalDataSourceImpl({required SharedPreferences preferences})
      : _preferences = preferences;

  final SharedPreferences _preferences;

  @override
  Future<bool> isUserLoggedIn() async {
    try {
      final result = _preferences.getString(AppConstant.tokenKey);
      if (result == null) {
        return false;
      }
      return true;
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}

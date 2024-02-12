import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/errors/exceptions.dart';

abstract class ProfileLocalDataSource {
  const ProfileLocalDataSource();

  Future<void> logout();
}

class ProfileLocalDataSourceImpl implements ProfileLocalDataSource {
  ProfileLocalDataSourceImpl({required SharedPreferences preferences})
      : _preferences = preferences;

  final SharedPreferences _preferences;

  @override
  Future<void> logout() async {
    try {
      await _preferences.remove(AppConstant.tokenKey);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}

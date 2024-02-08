import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/errors/exceptions.dart';

abstract class AuthLocalDataSource {
  const AuthLocalDataSource();

  Future<void> saveToken(String token);
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  AuthLocalDataSourceImpl({required SharedPreferences prefs}) : _prefs = prefs;
  final SharedPreferences _prefs;

  @override
  Future<void> saveToken(String token) async {
    try {
      await _prefs.setString(AppConstant.tokenKey, token);
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}

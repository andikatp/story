import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/features/auth/data/datasource/auth_local_datasource.dart';

class MockSharedPreference extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences mockSharedPreferences;
  late AuthLocalDataSource localDataSource;

  setUp(() {
    mockSharedPreferences = MockSharedPreference();
    localDataSource = AuthLocalDataSourceImpl(prefs: mockSharedPreferences);
  });

  group('saveToken', () {
    const token = 'test_token';

    test(
        'Should save the token successfully when '
        'SharedPreferences sets the token', () async {
      // arrange
      when(() => mockSharedPreferences.setString(any(), any()))
          .thenAnswer((_) async => true);
      // act
      await localDataSource.saveToken(token);
      // assert
      verify(() => mockSharedPreferences.setString(AppConstant.tokenKey, token))
          .called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}

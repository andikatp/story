import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/features/splash/data/datasources/splash_local_datasource.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late SharedPreferences mockSharedPreferences;
  late SplashLocalDataSource localData;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localData = SplashLocalDataSourceImpl(preferences: mockSharedPreferences);
  });

  group('getToken', () {
    const fToken = 'test_token';
    test(
        'Should get the token successfully when '
        'SharedPreferences fetch the token', () async {
      // arrange
      when(() => mockSharedPreferences.getString(any()))
          .thenAnswer((_) => fToken);
      // act
      final result = await localData.isUserLoggedIn();
      // assert
      expect(result, true);
      verify(() => mockSharedPreferences.getString(AppConstant.tokenKey))
          .called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}

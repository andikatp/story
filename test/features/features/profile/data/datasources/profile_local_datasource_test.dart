import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story/core/constants/app_constant.dart';
import 'package:story/features/profile/data/data/profile_local_datasource.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late ProfileLocalDataSource localData;
  late SharedPreferences mockSharedPreferences;

  setUp(() {
    mockSharedPreferences = MockSharedPreferences();
    localData = ProfileLocalDataSourceImpl(preferences: mockSharedPreferences);
  });

  group('logout', () {
    test(
        'Should remove the token successfully when '
        'SharedPreferences called', () async {
      // arrange
      when(() => mockSharedPreferences.remove(any()))
          .thenAnswer((_) async => true);
      // act
      await localData.logout();
      // assert
      verify(() => mockSharedPreferences.remove(AppConstant.tokenKey))
          .called(1);
      verifyNoMoreInteractions(mockSharedPreferences);
    });
  });
}

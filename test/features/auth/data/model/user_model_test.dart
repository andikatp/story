import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/auth/data/model/user_model.dart';
import 'package:story/features/auth/domain/entity/user_entity.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  late UserModel userModel;

  setUp(() => userModel = const UserModel.empty());

  test('Should be a subclass of [UserEntity] entity ', () async {
    // assert
    expect(userModel, isA<UserEntity>());
  });

  final tMap = jsonDecode(fixtureReader('user.json')) as ResultMap;
  const tUser = UserModel.empty();

  test('Should return a valid [userModel] from the map', () async {
    // act
    final result = UserModel.fromJson(tMap['loginResult'] as ResultMap);
    // assert
    expect(result, equals(tUser));
    expect(result, isA<UserModel>());
  });

  test(
    'Should return a valid [DataMap] from the model',
    () async {
      // act
      final result = tUser.toJson();
      // assert
      expect(result, equals(tMap['loginResult'] as ResultMap));
    }
  );
}

import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/dashboard/data/models/story_model.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';

import '../../../../fixture/fixture_reader.dart';

void main() {
  late StoryModel tStory;

  setUp(() => tStory = const StoryModel.empty());

  test('Should be a subclass of [StoryEntity] entity', () async {
    // assert
    expect(tStory, isA<StoryEntity>());
  });

  final tMap = jsonDecode(fixtureReader('story.json')) as ResultMap;
  final tStories = [const StoryModel.empty()];

  test('Should return a valid [userModel] from the map', () async {
    // arrange
    final storyList = tMap['listStory'] as List<dynamic>;
    // act
    final result =
        storyList.map((e) => StoryModel.fromJson(e as ResultMap)).toList();
    // assert
    expect(result, equals(tStories));
    expect(result, isA<List<StoryModel>>());
  });

  test('Should return a valid [DataMap] from the model', () async {
    // act
    final result = tStories[0].toJson();
    final tMap = {
      'id': '1',
      'name': '',
      'description': '',
      'photoUrl': '',
      'createdAt': '',
      'lat': 0.0,
      'lon': 0.0,
    };
    // assert
    expect(result, equals(tMap));
  });
}

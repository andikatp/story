import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/story/domain/repositories/story_repository.dart';
import 'package:story/features/story/domain/usecases/add_story.dart';

class MockStoryRepository extends Mock implements StoryRepository {}

void main() {
  late StoryRepository mockStoryRepository;
  late AddStory usecase;

  setUp(() {
    mockStoryRepository = MockStoryRepository();
    usecase = AddStory(repository: mockStoryRepository);
    registerFallbackValue(XFile(''));
  });

  group('addStory', () {
    final tParams = AddStoryParams.empty();
    test(
        'Should call [StoryRepository.addStory] '
        'and return a right value', () async {
      // arrange
      when(
        () => mockStoryRepository.addStory(
          file: any(named: 'file'),
          description: any(named: 'description'),
          isLocationAdded: any(named: 'isLocationAdded'),
        ),
      ).thenAnswer((_) async => const Right(null));
      // act
      final result = await usecase(tParams);
      // assert
      expect(result, const Right<dynamic, void>(null));
      verify(
        () => mockStoryRepository.addStory(
          file: tParams.file,
          description: tParams.description,
          isLocationAdded: tParams.isLocationAdded,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockStoryRepository);
    });

    test(
        'Should call [StoryRepository.addStory] '
        'and return a left value', () async {
      // arrange
      when(
        () => mockStoryRepository.addStory(
          file: any(named: 'file'),
          description: any(named: 'description'),
          isLocationAdded: any(named: ''),
        ),
      ).thenAnswer((_) async => const Left(ServerFailure(message: 'message')));
      // act
      final result = await usecase(tParams);
      // assert
      expect(
        result,
        const Left<Failure, dynamic>(ServerFailure(message: 'message')),
      );
      verify(
        () => mockStoryRepository.addStory(
          file: tParams.file,
          description: tParams.description,
          isLocationAdded: tParams.isLocationAdded,
        ),
      ).called(1);
      verifyNoMoreInteractions(mockStoryRepository);
    });
  });
}

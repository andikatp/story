import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';
import 'package:story/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:story/features/dashboard/domain/usecases/get_stories.dart';

class MockDashboardRepositories extends Mock implements DashboardRepository {}

void main() {
  late DashboardRepository mockRepository;
  late GetStories usecase;

  setUp(() {
    mockRepository = MockDashboardRepositories();
    usecase = GetStories(repository: mockRepository);
  });

  group('getStories', () {
    final tStories = [const StoryEntity.empty()];
    const tFailure = ServerFailure(message: 'message');
    test(
        'Should call [DashboardRepository.getStories] '
        'and return [List<StoryEntity>]', () async {
      // arrange
      when(() => mockRepository.getStories())
          .thenAnswer((_) async => Right(tStories));
      // act
      final result = await usecase();
      // assert
      expect(result, Right<dynamic, List<StoryEntity>>(tStories));
      verify(() => mockRepository.getStories()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });

    test('Should call [DashboardRepository.getStories] '
        'and return [ServerFailure]', () async {
      // arrange
      when(() => mockRepository.getStories())
          .thenAnswer((_) async => const Left(tFailure));
      // act
      final result = await usecase();
      // assert
      expect(result, const Left<Failure, dynamic>(tFailure));
      verify(() => mockRepository.getStories()).called(1);
      verifyNoMoreInteractions(mockRepository);
    });
  });
}

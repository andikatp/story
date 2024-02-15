import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/core/errors/failures.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';
import 'package:story/features/dashboard/domain/usecases/get_stories.dart';
import 'package:story/features/dashboard/presentation/bloc/dashboard_bloc.dart';

class MockGetStories extends Mock implements GetStories {}

void main() {
  late DashboardBloc bloc;
  late GetStories mockGetStories;

  setUp(() {
    mockGetStories = MockGetStories();
    bloc = DashboardBloc(getStories: mockGetStories);
  });

  tearDown(() {
    bloc.close();
  });

  group('DashboardBloc', () {
    final testStories = [const StoryEntity.empty()];

    blocTest<DashboardBloc, DashboardState>(
      'emits [loading, success] when GetStories succeeds',
      build: () {
        when(() => mockGetStories(any()))
            .thenAnswer((_) async => Right(testStories));
        return bloc;
      },
      act: (bloc) => bloc.add(const DashboardGetStories(page: 1)),
      expect: () => [
        DashboardState(
          status: StoryStatus.success,
          stories: testStories,
        ),
      ],
    );

    blocTest<DashboardBloc, DashboardState>(
      'emits [loading, error] when GetStories fails',
      build: () {
        when(() => mockGetStories(any())).thenAnswer(
          (_) async => const Left(ServerFailure(message: 'message')),
        );
        return bloc;
      },
      act: (bloc) => bloc.add(const DashboardGetStories(page: 1)),
      expect: () => [
        const DashboardState(
          status: StoryStatus.error,
          errorMessage: 'Error: message',
        ),
      ],
    );
  });
}

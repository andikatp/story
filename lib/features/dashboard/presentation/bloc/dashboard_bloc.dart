import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';
import 'package:story/features/dashboard/domain/usecases/get_stories.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required GetStories getStories,
  })  : _getStories = getStories,
        super(const DashboardState()) {
    on<DashboardEvent>((event, emit) async {
      if (event is DashboardGetStories && !state.hasReachedMax) {
        final result = await _getStories(event.page);
        result.fold(
          (failure) {
            emit(
              state.copyWith(
                status: StoryStatus.error,
                errorMessage: failure.errorMessage,
              ),
            );
          },
          (stories) {
            final newStories =
                stories.isEmpty ? <StoryEntity>[] : List.of(state.stories)
                  ..addAll(stories);
            final hasReachedMax = stories.isEmpty;
            emit(
              state.copyWith(
                status: StoryStatus.success,
                stories: newStories,
                hasReachedMax: hasReachedMax,
              ),
            );
          },
        );
      }
    });
  }

  final GetStories _getStories;
}

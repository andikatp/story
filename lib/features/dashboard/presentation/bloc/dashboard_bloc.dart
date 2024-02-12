import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story/core/errors/error_message.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';
import 'package:story/features/dashboard/domain/usecases/get_stories.dart';

part 'dashboard_event.dart';
part 'dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  DashboardBloc({
    required GetStories getStories,
  })  : _getStories = getStories,
        super(const DashboardInitial()) {
    on<DashboardEvent>((event, emit) {
      emit(const DashboardLoading());
    });
    on<DashboardGetStories>(getStoriesEvent);
  }

  final GetStories _getStories;

  Future<void> getStoriesEvent(
    DashboardGetStories event,
    Emitter<DashboardState> emit,
  ) async {
    final result = await _getStories(event.page);
    result.fold(
      (failure) => emit(DashboardError(message: errorMessage(failure))),
      (stories) => emit(DashboardLoaded(stories: stories)),
    );
  }
}

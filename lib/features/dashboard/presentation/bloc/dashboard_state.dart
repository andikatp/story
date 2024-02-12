part of 'dashboard_bloc.dart';

enum StoryStatus { loading, success, error }

class DashboardState extends Equatable {
  const DashboardState({
    this.status = StoryStatus.loading,
    this.hasReachedMax = false,
    this.stories = const [],
    this.errorMessage = '',
  });

  final StoryStatus status;
  final List<StoryEntity> stories;
  final bool hasReachedMax;
  final String errorMessage;

  DashboardState copyWith({
   StoryStatus? status,
   List<StoryEntity>? stories,
   bool? hasReachedMax,
   String? errorMessage,
  }) {
    return DashboardState(
      status: status ?? this.status,
      stories: stories ?? this.stories,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [status, stories, hasReachedMax, errorMessage];
}

// final class DashboardInitial extends DashboardState {
//   const DashboardInitial();
// }

// final class DashboardLoading extends DashboardState {
//   const DashboardLoading();
// }

// final class DashboardLoaded extends DashboardState {
//   const DashboardLoaded({required this.stories});
//   final List<StoryEntity> stories;

//   @override
//   List<Object> get props => [stories];
// }

// final class DashboardError extends DashboardState {
//   const DashboardError({required this.message});
//   final String message;

//   @override
//   List<Object> get props => [message];
// }

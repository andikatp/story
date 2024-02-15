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

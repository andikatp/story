part of 'dashboard_bloc.dart';

sealed class DashboardState extends Equatable {
  const DashboardState();

  @override
  List<Object> get props => [];
}

final class DashboardInitial extends DashboardState {
  const DashboardInitial();
}

final class DashboardLoading extends DashboardState {
  const DashboardLoading();
}

final class DashboardLoaded extends DashboardState {
  const DashboardLoaded({required this.stories});
  final List<StoryEntity> stories;

  @override
  List<Object> get props => [stories];
}

final class DashboardError extends DashboardState {
  const DashboardError({required this.message});
  final String message;

  @override
  List<Object> get props => [message];
}

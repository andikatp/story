part of 'dashboard_bloc.dart';

sealed class DashboardEvent extends Equatable {
  const DashboardEvent();

  @override
  List<Object> get props => [];
}

class DashboardGetStories extends DashboardEvent {
  const DashboardGetStories({required this.page});
  final int page;

  @override
  List<int> get props => [page];
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story/features/dashboard/presentation/bloc/dashboard_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DashboardBloc, DashboardState>(
        builder: (context, state) {
          if (state is DashboardLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          }
          if (state is DashboardError) {
            return Center(
              child: Text(state.message),
            );
          }
          if (state is DashboardLoaded) {
            print(state.stories);
            return const Center(
              child: Text('homepage'),
            );
          }
          return const SizedBox();
        },
      ),
    );
  }
}

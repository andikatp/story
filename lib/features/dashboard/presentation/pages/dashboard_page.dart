import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:story/features/dashboard/presentation/bloc/dashboard_bloc.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<DashboardBloc>().add(const DashboardGetStories());
    return const Scaffold(
      body: Center(
        child: Text('homepage'),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/core/services/router.dart';
import 'package:story/features/splash/presentation/cubit/splash_cubit.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void>.delayed(const Duration(seconds: 3)).then(
      (_) async => context.read<SplashCubit>().checkUserLoggedIn(),
    );

    return Scaffold(
      backgroundColor: Colours.secondaryColor,
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashUserChecked) {
            state.isUserLoggedIn
                ? context.goNamed(Routes.dashboard.name)
                : context.goNamed(Routes.auth.name);
          }
        },
        builder: (context, state) {
          return Center(
            child: Text(
              'StarOwl',
              style: context.headlineSmall.copyWith(
                fontWeight: FontWeight.w900,
              ),
            ),
          );
        },
      ),
    );
  }
}

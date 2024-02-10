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
    Future<void>.delayed(const Duration(seconds: 3)).then((_) async {
      final bloc = context.read<SplashCubit>();
      await bloc.checkUserLoggedIn();
      final state = bloc.state;
      if (!context.mounted) return;
      if (state is SplashUserChecked && state.isUserLoggedIn) {
        await context.pushNamed(Routes.dashboard.name);
      } else {
        await context.pushNamed(Routes.auth.name);
      }
    });

    return Scaffold(
      backgroundColor: Colours.secondaryColor,
      body: BlocConsumer<SplashCubit, SplashState>(
        listener: (context, state) {
          if (state is SplashUserChecked) {
            state.isUserLoggedIn
                ? context.goNamed(Routes.dashboard.name)
                : context.goNamed(Routes.login.name);
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

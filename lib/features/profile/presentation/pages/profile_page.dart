import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/services/router.dart';
import 'package:story/features/profile/presentation/cubit/profile_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    Future<void> logout() async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (context) => AlertDialog(
          title: const Text('Confirm Logout?'),
          content: const Text(
            'Are you sure you want to log out? Logging out will require you to '
            'sign in again to access your account.',
          ),
          actions: [
            TextButton(
              onPressed: () {
                context.read<ProfileCubit>().logout();
              },
              child: const Text('Yes'),
            ),
            Gap.h12,
            TextButton(onPressed: () => context.pop(), child: const Text('No')),
          ],
        ),
      );
    }

    return Scaffold(
      body: SafeArea(
        minimum: REdgeInsets.all(32),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is LoggedOut) {
              context.goNamed(Routes.auth.name);
            }
            if (state is ProfileError) {
              context.messengger.hideCurrentSnackBar();
              context.messengger
                  .showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return Center(
              child: ElevatedButton(
                onPressed: logout,
                child: const Text('Logout'),
              ),
            );
          },
        ),
      ),
    );
  }
}

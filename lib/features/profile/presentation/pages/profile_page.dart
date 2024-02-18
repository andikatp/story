import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/common/widgets/dropdown_flag.dart';
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
        builder: (ctx) => AlertDialog(
          title: const Text('LogoutTitle').tr(),
          content: const Text('LogoutMessage').tr(),
          actions: [
            TextButton(
              onPressed: () => context.read<ProfileCubit>().logout(),
              child: const Text('Yes').tr(),
            ),
            Gap.h12,
            TextButton(
              onPressed: () => context.pop(),
              child: const Text('No').tr(),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: REdgeInsets.only(right: 20),
            child: const DropdownFlag(),
          ),
        ],
      ),
      body: SafeArea(
        minimum: REdgeInsets.all(32),
        child: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is LoggedOut) {
              context.pushReplacementNamed(Routes.auth.name);
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
                child: Text(context.tr('Logout')),
              ),
            );
          },
        ),
      ),
    );
  }
}

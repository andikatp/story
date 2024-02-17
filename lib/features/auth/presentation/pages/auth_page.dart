import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/common/widgets/dropdown_flag.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/core/services/router.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    void goToLogin() => context.pushNamed(Routes.login.name);
    void goToRegister() => context.pushNamed(Routes.register.name);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: REdgeInsets.only(right: 20),
            child: const DropdownFlag(),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.only(top: Sizes.p56),
          child: Center(
            child: Column(
              children: [
                Text(
                  'StarOwl',
                  style: context.headlineMedium
                      .copyWith(fontWeight: FontWeight.w900),
                ),
                Gap.h60,
                SvgPicture.asset(
                  'assets/svg/astronout.svg',
                  width: 170.w,
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: REdgeInsets.symmetric(horizontal: Sizes.p32)
            .copyWith(bottom: Sizes.p16),
        child: Wrap(
          runSpacing: Sizes.p16.h,
          children: [
            ElevatedButton(
              onPressed: goToRegister,
              child: const Text('AuthSignUpButton').tr(),
            ),
            ElevatedButton(
              onPressed: goToLogin,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colours.backgroundColor,
                foregroundColor: Colours.whiteColor,
                side: const BorderSide(
                  color: Colours.whiteColor,
                  width: 1.5,
                ),
              ),
              child: const Text('AuthLoginButton').tr(),
            ),
          ],
        ),
      ),
    );
  }
}

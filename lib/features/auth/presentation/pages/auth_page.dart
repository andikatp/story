import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
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
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.only(top: 120.h),
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
                  'assets/svg/2.svg',
                  width: 170,
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
          runSpacing: 16.h,
          children: [
            ElevatedButton(
                onPressed: goToRegister, child: const Text('Sign Up'),),
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
              child: const Text('Log in'),
            ),
          ],
        ),
      ),
    );
  }
}

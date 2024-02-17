import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/core/services/router.dart';
import 'package:story/features/auth/presentation/widgets/dropdown_flag.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    void goToLogin() => context.pushNamed(Routes.login.name);
    void goToRegister() => context.pushNamed(Routes.register.name);
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: DropdownFlag(
              changedLanguage: (value) => context.setLocale(Locale(value)),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const NeverScrollableScrollPhysics(),
        child: Padding(
          padding: REdgeInsets.only(top: 56.h),
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
              onPressed: goToRegister,
              child: const Text('SignUp').tr(),
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
              child: const Text('LogIn').tr(),
            ),
          ],
        ),
      ),
    );
  }
}

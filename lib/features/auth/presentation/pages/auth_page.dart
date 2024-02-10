import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/extensions/extension.dart';
import 'package:story/core/res/colours.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: REdgeInsets.symmetric(horizontal: Sizes.p32)
            .copyWith(bottom: Sizes.p16),
        child: Wrap(
          runSpacing: 16.h,
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('Sign Up')),
            ElevatedButton(
              onPressed: () {},
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

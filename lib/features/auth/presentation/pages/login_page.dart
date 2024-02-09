import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story/core/constants/app_sizes.dart';
import 'package:story/core/res/colours.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: REdgeInsets.symmetric(horizontal: Sizes.p32),
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
                ),
              ),
              child: const Text('Log in'),
            ),
          ],
        ),
      ),
      body: SafeArea(
        minimum: REdgeInsets.all(32),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('StarOwl'),
              Placeholder(
                fallbackHeight: 0.4.sh,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

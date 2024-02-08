import 'package:flutter/material.dart';
import 'package:story/core/res/colours.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colours.secondaryColor,
      body: Center(
        child: Text(
          'StarOwl',
          style: Theme.of(context).textTheme.displayLarge,
        ),
      ),
    );
  }
}

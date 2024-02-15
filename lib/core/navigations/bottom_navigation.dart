import 'dart:io';

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/res/colours.dart';
import 'package:whatsapp_camera/camera/camera_whatsapp.dart';

class HomePage extends StatelessWidget {
  const HomePage({required this.navigationShell, Key? key})
      : super(key: key ?? const ValueKey('ScaffoldWithNestedNavigation'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    void goBranch(int index) {
      navigationShell.goBranch(
        index,
        initialLocation: index == navigationShell.currentIndex,
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [Icons.home, Icons.person],
        elevation: 0,
        inactiveColor: Colours.backgroundColor,
        activeColor: Colours.primaryColor,
        activeIndex: navigationShell.currentIndex,
        leftCornerRadius: 28,
        rightCornerRadius: 28,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        onTap: goBranch,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final res = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const WhatsappCamera(),
            ),
          );
        },
        shape: const CircleBorder(),
        child: const Icon(Icons.add_a_photo),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';
import 'package:story/core/res/colours.dart';
import 'package:story/core/services/router.dart';

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

    Future<void> handleImageSelection(
      ImageSource source,
      ImagePicker picker,
    ) async {
      final photo = await picker.pickImage(source: source);
      if (photo != null && context.mounted) {
        await context.pushNamed(
          Routes.addStory.name,
          extra: photo,
        );
      }
      if (context.mounted) {
        context.pop();
      }
    }

    Widget buildOption({
      required IconData icon,
      required String label,
      required VoidCallback onTap,
    }) {
      return Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          child: Wrap(
            direction: Axis.vertical,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              Icon(
                icon,
                size: 36.sp,
              ),
              Text(label),
            ],
          ),
        ),
      );
    }

    Future<void> takeStory() async {
      final picker = ImagePicker();
      await showDialog<AlertDialog>(
        context: context,
        builder: (context) => AlertDialog(
          content: SizedBox(
            height: 0.15.sh,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                buildOption(
                  icon: Icons.camera,
                  label: 'Camera',
                  onTap: () async {
                    await handleImageSelection(ImageSource.camera, picker);
                  },
                ),
                buildOption(
                  icon: Icons.image,
                  label: 'Gallery',
                  onTap: () async {
                    await handleImageSelection(ImageSource.gallery, picker);
                  },
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: const [Icons.home, Icons.person],
        inactiveColor: Colours.backgroundColor,
        activeColor: Colours.primaryColor,
        activeIndex: navigationShell.currentIndex,
        leftCornerRadius: 28,
        elevation: 0,
        rightCornerRadius: 28,
        notchSmoothness: NotchSmoothness.defaultEdge,
        gapLocation: GapLocation.center,
        onTap: goBranch,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: takeStory,
        shape: const CircleBorder(),
        child: const Icon(Icons.add_a_photo),
      ),
      floatingActionButtonAnimator: FloatingActionButtonAnimator.scaling,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }
}

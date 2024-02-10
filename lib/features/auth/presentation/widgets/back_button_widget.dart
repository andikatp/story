import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/services/router.dart';

class BackButtonWidget extends StatelessWidget {
  const BackButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () => context.goNamed(Routes.auth.name),
      icon: const Icon(Icons.chevron_left),
      iconSize: 36.sp,
    );
  }
}

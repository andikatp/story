import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/services/dependency_container.dart';
import 'package:story/features/splash_screen/presentation/cubit/splash_cubit.dart';
import 'package:story/features/splash_screen/presentation/pages/splash_page.dart';

part 'router.main.dart';

enum Routes {
  splash,
  dashboard,
  home,
}

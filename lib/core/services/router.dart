import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/services/dependency_container.dart';
import 'package:story/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:story/features/auth/presentation/pages/auth_page.dart';
import 'package:story/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:story/features/splash/presentation/cubit/splash_cubit.dart';
import 'package:story/features/splash/presentation/pages/splash_page.dart';

part 'router.main.dart';

enum Routes {
  splash,
  auth,
  login,
  register,
  dashboard,
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:story/core/navigations/bottom_navigation.dart';
import 'package:story/core/services/dependency_container.dart';
import 'package:story/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:story/features/auth/presentation/pages/auth_page.dart';
import 'package:story/features/auth/presentation/pages/login_page.dart';
import 'package:story/features/auth/presentation/pages/register_page.dart';
import 'package:story/features/dashboard/domain/entities/story_entity.dart';
import 'package:story/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:story/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:story/features/dashboard/presentation/pages/detail_page.dart';
import 'package:story/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:story/features/profile/presentation/pages/profile_page.dart';
import 'package:story/features/splash/presentation/pages/splash_page.dart';
import 'package:story/features/story/presentation/bloc/story_bloc.dart';
import 'package:story/features/story/presentation/pages/add_story.dart';

part 'router.main.dart';

enum Routes {
  splash,
  auth,
  login,
  register,
  home,
  dashboard,
  detail,
  profile,
  addStory,
}

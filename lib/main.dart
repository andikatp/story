import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story/core/res/theme.dart';
import 'package:story/core/services/dependency_container.dart';
import 'package:story/core/services/router.dart';
import 'package:story/features/splash/presentation/cubit/splash_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: ScreenUtilInit(
        designSize: const Size(412, 732),
        minTextAdapt: true,
        builder: (_, __) => BlocProvider(
          create: (context) => sl<SplashCubit>(),
          child: MaterialApp.router(
            routerConfig: router,
            theme: AppTheme.currentTheme,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

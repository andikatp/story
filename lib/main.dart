import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story/app_config.dart';
import 'package:story/core/res/theme.dart';
import 'package:story/core/services/dependency_container.dart';
import 'package:story/core/services/router.dart';
import 'package:story/features/splash/presentation/cubit/splash_cubit.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );
  await init();
  AppConfig.create(
    appName:
        AppConfig.shared.flavor == Flavor.paid ? 'Story Paid' : 'Story Free',
    flavor: AppConfig.shared.flavor == Flavor.paid ? Flavor.paid : Flavor.free,
  );
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('id')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const MyApp(),
    ),
  );
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
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
            routerConfig: router,
            theme: AppTheme.currentTheme,
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

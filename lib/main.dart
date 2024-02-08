import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story/core/res/theme.dart';
import 'package:story/core/services/dependency_container.dart';
import 'package:story/core/services/router.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 732),
      minTextAdapt: true,
      builder: (_, __) => MaterialApp.router(
        routerConfig: router,
        theme: AppTheme.currentTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

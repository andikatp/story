import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:story/core/services/dependency_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ScreenUtilInit(
      designSize: Size(412, 732),
      minTextAdapt: true,
      child: MaterialApp(
        home: Scaffold(
          body: Center(
            child: Text('its Working'),
          ),
        ),
      ),
    );
  }
}

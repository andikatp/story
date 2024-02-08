part of 'router.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _navigatorKey,
  debugLogDiagnostics: true,
  routerNeglect: true,
  routes: [
    GoRoute(
      path: '/',
      name: Routes.splash.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<SplashCubit>(),
        child: const SplashPage(),
      ),
    ),
    // StatefulShellRoute.indexedStack(
    //   builder: (context, _, navigationShell) => DashboardPage(
    //     navigationShell: navigationShell,
    //   ),
    //   branches: [
    //     StatefulShellBranch(
    //       routes: [
    //         GoRoute(
    //           path: '/home',
    //           name: Routes.home.name,
    //           builder: (context, _) => const MainPage(),
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  ],
);

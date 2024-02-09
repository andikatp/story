part of 'router.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/login',
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
    GoRoute(
      path: '/login',
      name: Routes.login.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AuthBloc>(),
        child: const LoginPage(),
      ),
    ),
    GoRoute(
      path: '/dashboard',
      name: Routes.dashboard.name,
      builder: (context, state) => const DashboardPage(),
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

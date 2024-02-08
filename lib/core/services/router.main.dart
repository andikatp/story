part of 'router.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/home',
  routerNeglect: true,
  routes: [
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

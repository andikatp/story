part of 'router.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/dashboard',
  routerNeglect: true,
  routes: [
    GoRoute(
      path: '/',
      name: Routes.splash.name,
      builder: (_, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/auth',
      name: Routes.auth.name,
      builder: (context, state) => BlocProvider(
        create: (context) => sl<AuthBloc>(),
        child: const AuthPage(),
      ),
      routes: [
        GoRoute(
          path: 'login',
          name: Routes.login.name,
          pageBuilder: (context, state) => CustomSlideTransition(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const LoginPage(),
            ),
          ),
        ),
        GoRoute(
          path: 'register',
          name: Routes.register.name,
          pageBuilder: (context, state) => CustomSlideTransition(
            key: state.pageKey,
            child: BlocProvider(
              create: (context) => sl<AuthBloc>(),
              child: const RegisterPage(),
            ),
          ),
        ),
      ],
    ),
    GoRoute(
      path: '/dashboard',
      name: Routes.dashboard.name,
      builder: (context, state) => BlocProvider(
        create: (context) =>
            sl<DashboardBloc>()..add(const DashboardGetStories()),
        child: const DashboardPage(),
      ),
    ),
    GoRoute(
      path: '/home',
      name: Routes.home.name,
      builder: (context, state) => const HomePage(),
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

class CustomSlideTransition extends CustomTransitionPage<void> {
  CustomSlideTransition({required super.child, super.key})
      : super(
          transitionDuration: const Duration(milliseconds: 250),
          transitionsBuilder: (_, animation, __, child) {
            return SlideTransition(
              position: animation.drive(
                Tween(
                  begin: const Offset(1.5, 0),
                  end: Offset.zero,
                ).chain(
                  CurveTween(curve: Curves.ease),
                ),
              ),
              child: child,
            );
          },
        );
}

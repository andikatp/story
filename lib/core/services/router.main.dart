part of 'router.dart';

final GlobalKey<NavigatorState> _navigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: _navigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/',
  routerNeglect: true,
  routes: [
    GoRoute(
      path: '/',
      name: Routes.splash.name,
      builder: (_, __) => const SplashPage(),
    ),
    GoRoute(
      path: '/auth',
      name: Routes.auth.name,
      builder: (_, __) => BlocProvider(
        create: (_) => sl<AuthBloc>(),
        child: const AuthPage(),
      ),
      routes: [
        GoRoute(
          path: 'login',
          name: Routes.login.name,
          pageBuilder: (_, state) => CustomSlideTransition(
            key: state.pageKey,
            child: BlocProvider(
              create: (_) => sl<AuthBloc>(),
              child: const LoginPage(),
            ),
          ),
        ),
        GoRoute(
          path: 'register',
          name: Routes.register.name,
          pageBuilder: (_, state) => CustomSlideTransition(
            key: state.pageKey,
            child: BlocProvider(
              create: (_) => sl<AuthBloc>(),
              child: const RegisterPage(),
            ),
          ),
        ),
      ],
    ),
    StatefulShellRoute.indexedStack(
      builder: (_, __, navigationShell) => HomePage(
        navigationShell: navigationShell,
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/dashboard',
              name: Routes.dashboard.name,
              builder: (_, __) => BlocProvider(
                create: (_) => sl<DashboardBloc>(),
                child: const DashboardPage(),
              ),
              routes: [
                GoRoute(
                  path: 'detail',
                  name: Routes.detail.name,
                  builder: (_, state) {
                    final story = state.extra! as StoryEntity;
                    return DetailPage(story: story);
                  },
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: '/profile',
              name: Routes.profile.name,
              builder: (_, __) => BlocProvider(
                create: (_) => sl<ProfileCubit>(),
                child: const ProfilePage(),
              ),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/add-story',
      name: Routes.addStory.name,
      builder: (_, state) {
        final image = state.extra! as XFile;

        return BlocProvider(
          create: (_) => sl<StoryBloc>(),
          child: AddStoryPage(image: image),
        );
      },
      routes: [
        GoRoute(
          path: 'location-add-story',
          name: Routes.addLocationStory.name,
          builder: (_, state) => BlocProvider(
            create: (_) => sl<StoryBloc>(),
            child: const LocationMapPage(),
          ),
        ),
      ],
    ),
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

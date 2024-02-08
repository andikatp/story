part of 'dependency_container.dart';

final sl = GetIt.instance;

Future<void> init() async {
  await _initSplash();
  await _initAuth();
}

Future<void> _initSplash() async {
  //feature --> Splash
  //Business Logic
  sl
    ..registerFactory(() => SplashCubit(checkUserLoggedIn: sl()))
    // usecases
    ..registerLazySingleton(() => CheckUserLoggedIn(repository: sl()))
    // repositories
    ..registerLazySingleton<SplashRepository>(
      () => SplashRepositoryImpl(localDataSource: sl()),
    )
    // datasources
    ..registerLazySingleton<SplashLocalDataSource>(
      () => SplashLocalDataSourceImpl(preferences: sl()),
    );
}

Future<void> _initAuth() async {
  //feature --> Auth
  //Business Logic
  sl
    ..registerFactory(
      () => AuthBloc(login: sl(), register: sl(), saveToken: sl()),
    )
    // usecases
    ..registerLazySingleton(() => Login(repository: sl()))
    ..registerLazySingleton(() => Register(repository: sl()))
    ..registerLazySingleton(() => SaveToken(repository: sl()))
    // repositories
    ..registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ),
    )
    // datasources
    ..registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSourceImpl(client: sl()),
    )
    ..registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSourceImpl(prefs: sl()),
    )
    // others
    ..registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(networkInfo: sl()),
    )
    ..registerLazySingleton(InternetConnection.new)
    ..registerLazySingleton(http.Client.new)
    ..registerSingletonAsync(SharedPreferences.getInstance);
}

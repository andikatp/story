import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:story/features/splash/domain/usecases/check_user_logged_in.dart';
import 'package:story/features/splash/presentation/cubit/splash_cubit.dart';

class MockCheckUserLoggedIn extends Mock implements CheckUserLoggedIn {}

void main() {
  late SplashCubit cubit;
  late CheckUserLoggedIn mockCheckUserLoggedIn;

  setUp(() {
    mockCheckUserLoggedIn = MockCheckUserLoggedIn();
    cubit = SplashCubit(checkUserLoggedIn: mockCheckUserLoggedIn);
  });

  test('Should get [AuthInitial] as initial state', () async {
    // assert
    expect(cubit.state, const SplashInitial());
  });

  blocTest<SplashCubit, SplashState>(
    'Should emit [SplashLoading] and [SplashUserChecked] '
    'when data is gotten successfully',
    build: () {
      when(() => mockCheckUserLoggedIn())
          .thenAnswer((_) async => const Right(true));
      return cubit;
    },
    act: (cubit) => cubit.checkUserLoggedIn(),
    expect: () => [
      const SplashLoading(),
      const SplashUserChecked(isUserLoggedIn: true),
    ],
  );
}

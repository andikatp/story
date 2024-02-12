import 'package:story/core/utils/typedef.dart';

abstract class ProfileRepository {
  const ProfileRepository();

  ResultFuture<void> logout();
}

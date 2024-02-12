import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/profile/domain/repositories/profile_repository.dart';

class Logout implements UseCaseWithoutParams<void> {
  Logout({required ProfileRepository repository}) : _repository = repository;
  final ProfileRepository _repository;

  @override
  ResultFuture<void> call() => _repository.logout();
}

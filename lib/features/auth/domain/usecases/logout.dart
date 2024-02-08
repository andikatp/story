import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/auth/domain/repositories/auth_repository.dart';

class Logout implements UseCaseWithoutParams<void> {
  Logout({required AuthRepository repository}) : _repository = repository;

  final AuthRepository _repository;

  @override
  ResultFuture<void> call() => _repository.logout();
}

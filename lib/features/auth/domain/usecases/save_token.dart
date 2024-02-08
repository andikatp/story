import 'package:story/core/usecases/usecases.dart';
import 'package:story/core/utils/typedef.dart';
import 'package:story/features/auth/domain/repositories/auth_repository.dart';

class SaveToken implements UseCaseWithParams<void, String> {
  SaveToken({required AuthRepository repository}) : _repository = repository;
  final AuthRepository _repository;

  @override
  ResultFuture<void> call(String token) => _repository.saveToken(token: token);
}

import 'package:story/core/utils/typedef.dart';

abstract class UseCaseWithoutParams<Type> {
  const UseCaseWithoutParams();

  ResultFuture<Type> call();
}

abstract class UseCaseWithParams<Type, Params> {
  const UseCaseWithParams();
  
  ResultFuture<Type> call(Params params);
}

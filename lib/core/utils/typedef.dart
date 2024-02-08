import 'package:dartz/dartz.dart';
import 'package:story/core/errors/failures.dart';

typedef ResultFuture<Type> = Future<Either<Failure, Type>>;
typedef ResultMap = Map<String, dynamic>;

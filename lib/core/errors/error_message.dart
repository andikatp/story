

import 'package:story/core/constants/app_constant.dart';
import 'package:story/core/errors/failures.dart';

String errorMessage(Failure failure) {
  switch (failure.runtimeType) {
    case ServerFailure:
      return AppConstant.serverFailureMessage;
    case CacheFailure:
      return AppConstant.cacheFailureMessage;
    default:
      return AppConstant.generalFailureMessage;
  }
}

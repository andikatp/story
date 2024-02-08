class AppConstant {
  const AppConstant._();

  //network stuff
  static const String baseUrl = 'https://story-api.dicoding.dev/v1';
  static const int successfulHttpGetStatusCode = 200;
  static const int successfulHttpPostStatusCode = 201;

  // error message
  static const String noInternetConnection = 'Please check your connection';
  static const String serverFailureMessage =
      'Ups, API Error. please try again!';
  static const String cacheFailureMessage = 'Ups, API Error. please try again!';
  static const String generalFailureMessage = 'Ups, check your connection';

  // key
  static const String tokenKey = 'userToken';

  // theme
  static const String font = 'Roboto';
}

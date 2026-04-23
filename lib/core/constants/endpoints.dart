/// ApiEndpoint
///
/// This class contains all the API path suffixes.
///
/// How it works:
/// The app combines the BaseURL (from Environment) + Endpoint to make a full request.
/// Example: `https://dummyjson.com/` + `auth/login`
class ApiEndpoint {
  /// Auth endpoints
  static const String login = 'auth/login';
  static const String authMe = 'auth/me';
  static const String refreshToken = 'auth/refresh';

  /// Dashboard endpoints
  static const String products = 'products';
}

/// Available application environments.
/// 
/// - [dev] - Development environment for local testing
/// - [stage] - Staging/UAT environment for pre-production testing
/// - [prod] - Production environment for live users
enum AppEnvironment { dev, stage, prod }

/// EnvInfo - Environment Information Provider
/// 
/// Abstract class that provides environment-specific configuration.
/// Call [initialize] once at app startup to set the current environment.
/// 
/// Example:
/// ```dart
/// EnvInfo.initialize(AppEnvironment.dev);
/// print(EnvInfo.baseUrl); // https://dev-api.example.com/
/// ```
abstract class EnvInfo {
  static AppEnvironment _environment = AppEnvironment.dev;

  /// Initializes the environment configuration.
  /// 
  /// Must be called once in [mainCommon] before accessing any properties.
  static void initialize(AppEnvironment environment) {
    EnvInfo._environment = environment;
  }

  /// Returns the display name of the app based on environment.
  static String get appName => _environment._appTitle;

  /// Returns the environment name (dev, uat, prod).
  static String get envName => _environment._envName;

  /// Returns the database connection string (if applicable).
  static String get connectionString => _environment._connectionString;

  /// Returns the API base URL for the current environment.
  static String get baseUrl => _environment._baseUrls;

  /// Returns the web page URL for the current environment.
  static String get webPageUrl => _environment._webPageUrls;

  /// Returns the current environment enum value.
  static AppEnvironment get environment => _environment;

  /// Returns true if the app is running in production mode.
  static bool get isProduction => _environment == AppEnvironment.prod;
}

/// Private extension to provide environment-specific values.
/// 
/// Add your environment-specific configurations here.
extension _EnvProperties on AppEnvironment {
  /// App display names per environment.
  static const _appTitles = {
    AppEnvironment.dev: 'BLOC Dev',
    AppEnvironment.stage: 'BLOC Staging',
    AppEnvironment.prod: 'BLOC Prod',
  };

  /// Database connection strings (currently unused).
  static const _connectionStrings = {
    AppEnvironment.dev: '',
    AppEnvironment.stage: '',
    AppEnvironment.prod: '',
  };

  /// API base URLs per environment.
  /// 
  /// Update these with your actual API endpoints.
  static const _baseUrl = {
    AppEnvironment.dev: 'https://dummyjson.com/',
    AppEnvironment.stage: 'https://dummyjson.com/',
    AppEnvironment.prod: 'https://dummyjson.com/',
  };

  /// Environment short names for logging/debugging.
  static const _envs = {
    AppEnvironment.dev: 'dev',
    AppEnvironment.stage: 'uat',
    AppEnvironment.prod: 'prod',
  };

  /// Web page URLs per environment (for WebViews, etc.).
  static const _webPageUrl = {
    AppEnvironment.dev: 'http://example1.com',
    AppEnvironment.stage: 'https://bexample2.com',
    AppEnvironment.prod: 'https://example3.com',
  };

  String get _appTitle => _appTitles[this]!;

  String get _envName => _envs[this]!;

  String get _connectionString => _connectionStrings[this]!;

  String get _baseUrls => _baseUrl[this]!;

  String get _webPageUrls => _webPageUrl[this]!;
}

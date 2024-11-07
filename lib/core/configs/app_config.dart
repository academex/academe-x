enum Environment { dev, prod, staging }

class AppConfig {
  static late final Environment environment;
  static late final String apiBaseUrl;

  static void initialize(Environment env) {
    environment = env;
    switch (env) {
      case Environment.dev:
        apiBaseUrl = 'https://dev-api.academx.com';
        break;
      case Environment.staging:
        apiBaseUrl = 'https://staging-api.academx.com';
        break;
      case Environment.prod:
        apiBaseUrl = 'https://api.academx.com';
        break;
    }
  }
}
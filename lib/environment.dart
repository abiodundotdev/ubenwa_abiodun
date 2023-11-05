class Environment {
  static Env get fromConfig {
    String _env = const String.fromEnvironment("env.mode");
    switch (_env) {
      case "mock":
        return Env.mock;
      case "staging":
        return Env.staging;
      case "dev":
        return Env.dev;
      case "prod":
        return Env.prod;
      default:
        return Env.prod;
    }
  }
}

///The current environment the app is running on  [prod|mock|dev|staging]
enum Env {
  prod("https://api.ubenwa.co/"),
  mock("https://api.ubenwa.co/"),
  staging("https://api.ubenwa.co/"),
  dev("https://api.ubenwa.co/");

  final String httpBaseUrl;
  const Env(this.httpBaseUrl);

  bool get isMock => this == Env.mock;
  bool get isProd => this == Env.prod;
  bool get isStaging => this == Env.prod;
  bool get isDev => this == Env.dev;
}

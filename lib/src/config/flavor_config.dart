enum Flavor { dev, staging, prod }

class FlavorConfig {
  final Flavor flavor;
  final String baseUrl;

  static FlavorConfig? _instance;

  FlavorConfig._({required this.flavor, required this.baseUrl});  

  factory FlavorConfig({required Flavor flavor, required String baseUrl}) {
    // initialize only once
    return _instance ??= FlavorConfig._(flavor: flavor, baseUrl: baseUrl);
  }

  // Return nullable instance instead of using !
  static FlavorConfig? get instance => _instance;

  bool get isDev => flavor == Flavor.dev;
  bool get isStaging => flavor == Flavor.staging;
  bool get isProd => flavor == Flavor.prod;

  /// Factory method to initialize from environment
  static FlavorConfig fromEnv(String env) {
    switch (env) {
      case 'dev':
        return FlavorConfig(
          flavor: Flavor.dev,
          baseUrl: 'https://api.dev.example.com',
        );
      case 'staging':
        return FlavorConfig(
          flavor: Flavor.staging,
          baseUrl: 'https://api.staging.example.com',
        );
      case 'prod':
        return FlavorConfig(
          flavor: Flavor.prod,
          baseUrl: 'https://api.example.com',
        );
      default:
        throw Exception('Unknown flavor: $env');
    }
  }
}

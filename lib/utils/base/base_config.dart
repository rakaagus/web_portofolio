class BaseConfig {
  static ENV currentBuild = ENV.dev;
  static String baseURLDev = "";
  static String baseURLProd = "";
  static String baseURL = "";
  static String name = "";
}

enum ENV {
  prod,
  dev
}
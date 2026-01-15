class BaseConfig {
  static ENV currentBuild = ENV.dev;
  static String baseURLDev = "";
  static String baseURLProd = "";
  static String baseURL = "";
}

enum ENV {
  prod,
  dev
}
class AppRoutes {
  AppRoutes._();

  static const String home = '/';
  static const String experience = '/experience';
  static const String projects = '/projects';
  static const String projectDetail = '/projects/:slug';
  static const String blogs = '/blogs';
  static const String blogDetail = '/blogs/:slug';

  /// Helper untuk membuat path detail project dengan slug/id
  static String projectDetailPath(String slug) => '/projects/$slug';

  /// Helper untuk membuat path detail blog dengan slug
  static String blogDetailPath(String slug) => '/blogs/$slug';
}


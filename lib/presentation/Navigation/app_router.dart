import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/Navigation/app_routes.dart';
import 'package:web_portofolio/presentation/bloc/blog/blog_detail_screen.dart';
import 'package:web_portofolio/presentation/bloc/blog/blog_screen.dart';
import 'package:web_portofolio/presentation/bloc/experience/experience_screen.dart';
import 'package:web_portofolio/presentation/bloc/home/home_screen.dart';
import 'package:web_portofolio/presentation/bloc/not_found/not_found_screen.dart';
import 'package:web_portofolio/presentation/bloc/project/project_detail_screen.dart';
import 'package:web_portofolio/presentation/bloc/project/project_screen.dart';

class AppRouter {
  AppRouter._();

  static Route<dynamic> onGenerateRoute(RouteSettings settings) {
    final uri = Uri.parse(settings.name ?? AppRoutes.home);
    Widget page;

    if (uri.path == AppRoutes.home) {
      page = const HomeScreen();
    } else if (uri.path == AppRoutes.experience) {
      page = const ExperienceScreen();
    } else if (uri.path == AppRoutes.projects) {
      page = const ProjectScreen();
    } else if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'projects') {
      final slug = uri.pathSegments[1];
      page = ProjectDetailScreen(slug: slug);
    } else if (uri.path == AppRoutes.blogs) {
      page = const BlogScreen();
    } else if (uri.pathSegments.length == 2 && uri.pathSegments.first == 'blogs') {
      final slug = uri.pathSegments[1];
      page = BlogDetailScreen(slug: slug);
    } else {
      return MaterialPageRoute(
        settings: settings,
        builder: (_) => const NotFoundScreen(),
      );
    }

    return PageRouteBuilder(
      settings: settings,
      opaque: true,
      pageBuilder: (context, animation, secondaryAnimation) {
        final isDark = Theme.of(context).brightness == Brightness.dark;
        return Container(
          color: isDark ? const Color(0xFF000000) : const Color(0xFFF8FAFC),
          child: page,
        );
      },
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final tween = Tween<Offset>(
          begin: const Offset(0.0, 0.05),
          end: Offset.zero,
        ).chain(CurveTween(curve: Curves.easeOutCubic));

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: animation.drive(tween),
            child: child,
          ),
        );
      },
      transitionDuration: const Duration(milliseconds: 400),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/bloc/blog/blog_screen.dart';
import 'package:web_portofolio/presentation/bloc/education/education_screen.dart';
import 'package:web_portofolio/presentation/bloc/experience/experience_screen.dart';
import 'package:web_portofolio/presentation/bloc/home/home_screen.dart' show HomeScreen;
import 'package:web_portofolio/presentation/bloc/not_found/not_found_screen.dart';
import 'package:web_portofolio/presentation/bloc/project/project_screen.dart';
import 'package:web_portofolio/utils/color_theme.dart';
import 'package:web_portofolio/utils/type_theme.dart';
import 'package:flutter_web_plugins/url_strategy.dart';

void main() {
  usePathUrlStrategy();
  runApp(MyPortoApp());
}

class MyPortoApp extends StatelessWidget{
  final ligtColorSchema = ColorScheme.light(
    primary: LightColorTheme.primaryColor,
    secondary: LightColorTheme.secondaryColor,
    surface: LightColorTheme.backgroundColor,
    onSurface: LightColorTheme.textColor,
  );

  final darkColorSchema = ColorScheme.dark(
    primary: DarkColorTheme.primaryColor,
    surface: DarkColorTheme.surfaceColor,
    onSurface: DarkColorTheme.textPrimaryColor,
    onSurfaceVariant: DarkColorTheme.textSecondaryColor,
  );

  @override
  Widget build(BuildContext context) => MaterialApp(
    title: "Raka Agus - Mobile Dev",
    theme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      scaffoldBackgroundColor: LightColorTheme.backgroundColor,
      primaryColor: LightColorTheme.primaryColor,
      colorScheme: ligtColorSchema,
      textTheme: AppTypography.getTheme(ligtColorSchema),
    ),
    darkTheme: ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: DarkColorTheme.backgroundColor,
      colorScheme: darkColorSchema,
      textTheme: AppTypography.getTheme(darkColorSchema)
    ),
    initialRoute: '/',
    onGenerateRoute: (settings) {
      Widget page;
      switch (settings.name) {
        case '/':
          page = const HomeScreen();
          break;
        case '/experience':
          page = const ExperienceScreen();
          break;
        case '/education':
          page = const EducationScreen();
          break;
        case '/projects':
          page = const ProjectScreen();
          break;
        case '/blogs':
          page = const BlogScreen();
          break;
        default:
          return MaterialPageRoute(
            settings: settings,
            builder: (context) => const NotFoundScreen(),
          );
      }
      return PageRouteBuilder(
        settings: settings,
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final tween = Tween<Offset>(begin: const Offset(0.0, 0.05), end: Offset.zero)
              .chain(CurveTween(curve: Curves.easeOutCubic));
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
    },
    onUnknownRoute: (settings) {
      return MaterialPageRoute(
        settings: settings,
        builder: (context) => const NotFoundScreen(),
      );
    },
  );
}
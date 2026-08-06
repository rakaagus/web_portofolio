import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/presentation/bloc/blog/blog_screen.dart';
import 'package:web_portofolio/presentation/bloc/experience/experience_screen.dart';
import 'package:web_portofolio/presentation/bloc/home/home_screen.dart' show HomeScreen;
import 'package:web_portofolio/presentation/bloc/not_found/not_found_screen.dart';
import 'package:web_portofolio/presentation/bloc/project/project_screen.dart';
import 'package:web_portofolio/utils/color_theme.dart';
import 'package:web_portofolio/utils/enum/locale_cubit.dart';
import 'package:web_portofolio/utils/enum/theme_cubit.dart';
import 'package:web_portofolio/utils/type_theme.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

final ValueNotifier<Locale> currentLocale = ValueNotifier(const Locale('en'));

void main() {
  usePathUrlStrategy();
  runApp(
    MultiBlocProvider(
        providers: [
          BlocProvider(create: (_) => LocaleCubit()),
          BlocProvider(create: (_) => ThemeCubit())
        ],
        child: MyPortoApp()
    )
  );
}

class MyPortoApp extends StatelessWidget {
  MyPortoApp({super.key});

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
  Widget build(BuildContext context) {
    final locale = context.watch<LocaleCubit>().state;
    final themeMode = context.watch<ThemeCubit>().state;

    return MaterialApp(
      title: "Raka Agus - Mobile Dev",
      locale: locale,
      themeMode: themeMode,
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
        textTheme: AppTypography.getTheme(darkColorSchema),
      ),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      localeResolutionCallback: (deviceLocale, supportedLocales) {
        if (deviceLocale != null && deviceLocale.languageCode == 'id') {
          return const Locale('id');
        }

        return const Locale('en');
      },
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
          opaque: true,
          pageBuilder: (context, animation, secondaryAnimation) {
            final isDark = Theme.of(context).brightness == Brightness.dark;
            return Container(
              color: isDark ? const Color(0xFF000000) : const Color(0xFFF8FAFC),
              child: page,
            );
          },
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
}
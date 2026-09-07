import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:web_portofolio/presentation/Navigation/app_router.dart';
import 'package:web_portofolio/presentation/Navigation/app_routes.dart';
import 'package:web_portofolio/utils/color_theme.dart';
import 'package:web_portofolio/utils/enum/locale_cubit.dart';
import 'package:web_portofolio/utils/enum/theme_cubit.dart';
import 'package:web_portofolio/utils/type_theme.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:web_portofolio/di/injection_container.dart';

final ValueNotifier<Locale> currentLocale = ValueNotifier(const Locale('en'));

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await dotenv.load(fileName: ".env");
  } catch (e) {
    debugPrint("[Dotenv] .env file not found or failed to load: $e");
  }
  await setupLocator();
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
      initialRoute: AppRoutes.home,
      onGenerateRoute: AppRouter.onGenerateRoute,
    );
  }
}
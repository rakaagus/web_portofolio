import 'package:flutter/material.dart';
import 'package:web_portofolio/presentation/bloc/home/home_screen.dart' show HomeScreen;
import 'package:web_portofolio/presentation/bloc/loading/loading_screen.dart';
import 'package:web_portofolio/utils/color_theme.dart';
import 'package:web_portofolio/utils/type_theme.dart';

void main() {
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
    home: const LoadingScreen(),
    routes: {
      '/home' : (context) => HomeScreen(),
    },
  );
}
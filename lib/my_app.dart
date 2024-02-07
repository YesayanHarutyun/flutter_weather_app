import 'package:flutter/material.dart';
import 'package:flutter_weather_app/navigation/navigation.dart';
import 'package:flutter_weather_app/presentation/apptheme/app_theme_provider.dart';
import 'package:flutter_weather_app/presentation/theme_provider.dart';
import 'package:provider/provider.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  AppThemeProvider themeChangeProvider = AppThemeProvider();

  @override
  void initState() {
    super.initState();
    getCurrentAppTheme();
  }

  void getCurrentAppTheme() async => themeChangeProvider.darkTheme =
      await themeChangeProvider.darkThemePreference.getSelectedTheme();

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (_) => themeChangeProvider,
        child: Consumer<AppThemeProvider>(
          builder: (context, value, child) {
            return MaterialApp(
              themeAnimationDuration: const Duration(milliseconds: 250),
              debugShowCheckedModeBanner: false,
              theme: getAppTheme(context, themeChangeProvider.darkTheme),
              home: MainNavigator(),
            );
          },
        ),
      );
}

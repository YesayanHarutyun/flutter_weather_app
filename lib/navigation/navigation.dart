import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_weather_app/navigation/bottom_nav_controller_provider.dart';
import 'package:flutter_weather_app/navigation/weather_nav_screens.dart';
import 'package:flutter_weather_app/presentation/apptheme/app_theme_provider.dart';
import 'package:flutter_weather_app/presentation/constants/constants.dart';
import 'package:flutter_weather_app/presentation/view/favourite_cities_screen.dart';
import 'package:flutter_weather_app/presentation/view/home_screen.dart';
import 'package:flutter_weather_app/presentation/view/settings_screen.dart';
import 'package:provider/provider.dart' as provider;

class MainNavigator extends ConsumerWidget {
  MainNavigator({super.key});

  final List<Widget> _screens = [
    HomeScreen(),
    FavouriteCitiesScreen(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final WeatherNavScreens selectedScreen =
        ref.watch(bottomNavControllerProvider);
    final appThemeProvider = provider.Provider.of<AppThemeProvider>(context);
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: dp_0,
        title: Text(
          selectedScreen.title,
          style: const TextStyle(
            color: Colors.blueAccent,
          ),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        elevation: dp_0,
        currentIndex: selectedScreen.index,
        items: WeatherNavScreens.values
            .map(
              (screen) => BottomNavigationBarItem(
                activeIcon: SvgPicture.asset(
                  key: Key("${screen.id}_checked"),
                  screen.svgPictureActiveIcon,
                ),
                icon: SvgPicture.asset(
                  key: Key("${screen.id}_unchecked"),
                  screen.svgPictureIcon,
                ),
                label: "",
              ),
            )
            .toList(),
        onTap: (i) {
          ref
              .read(bottomNavControllerProvider.notifier)
              .setSelectedScreen(WeatherNavScreens.values[i]);
        },
      ),
      body: Container(
        decoration: appThemeProvider.darkTheme
            ? BoxDecoration(
                gradient: darkModeBlueGradient,
              )
            : BoxDecoration(
                gradient: lightModePurpleGradient,
              ),
        child: IndexedStack(
          index: selectedScreen.index,
          children: _screens,
        ),
      ),
    );
  }
}

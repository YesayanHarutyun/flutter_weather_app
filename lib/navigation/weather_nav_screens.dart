import 'package:flutter_weather_app/presentation/constants/strings.dart';

enum WeatherNavScreens {
  home(
    "home",
    Strings.home,
    Strings.homeActiveIconPath,
    Strings.homeInactiveIconPath,
  ),
  favourites(
    "favourites",
    Strings.favourites,
    Strings.favouriteActiveIconPath,
    Strings.favouriteInactiveIconPath,
  ),
  settings(
    "settings",
    Strings.settings,
    Strings.settingsActiveIconPath,
    Strings.settingsInactiveIconPath,
  );

  final String id;
  final String title;
  final String svgPictureActiveIcon;
  final String svgPictureIcon;

  const WeatherNavScreens(
      this.id, this.title, this.svgPictureActiveIcon, this.svgPictureIcon);
}

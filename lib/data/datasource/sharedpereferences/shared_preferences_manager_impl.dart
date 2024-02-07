import 'dart:core';

import 'package:flutter_weather_app/domain/sharedpreferences/shared_preferences_manager.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String theme = "theme";
const String currentCity = "currentCity";

class SharedPreferencesManagerImpl implements SharedPreferencesManager {
  Future<SharedPreferences> get _prefs async => SharedPreferences.getInstance();

  @override
  Future<bool> getSelectedTheme() async =>
      (await _prefs).getBool(theme) ?? false;

  @override
  Future<void> setSelectedTheme(bool value) async =>
      (await _prefs).setBool(theme, value);

  @override
  Future<String?> getCurrentCity() async =>
      (await _prefs).getString(currentCity) ?? "";

  @override
  Future<void> setCurrentCity(String cityName) async =>
      (await _prefs).setString(currentCity, cityName);
}

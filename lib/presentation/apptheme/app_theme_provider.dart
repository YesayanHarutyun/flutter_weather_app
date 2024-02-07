import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/data/datasource/sharedpereferences/shared_preferences_manager_impl.dart';
import 'package:flutter_weather_app/domain/sharedpreferences/shared_preferences_manager.dart';

final appThemeNotifierProvider =
ChangeNotifierProvider<AppThemeProvider>((ref) => AppThemeProvider());

class AppThemeProvider with ChangeNotifier {
  SharedPreferencesManager darkThemePreference = SharedPreferencesManagerImpl();
  bool _darkTheme = false;

  bool get darkTheme => _darkTheme;

  set darkTheme(bool value) {
    _darkTheme = value;
    darkThemePreference.setSelectedTheme(value);
    notifyListeners();
  }
}

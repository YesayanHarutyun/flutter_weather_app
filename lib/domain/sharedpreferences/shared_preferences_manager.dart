abstract class SharedPreferencesManager {
  Future<void> setSelectedTheme(bool value);
  Future<bool> getSelectedTheme();
  Future<void> setCurrentCity(String cityName);
  Future<String?> getCurrentCity();
}
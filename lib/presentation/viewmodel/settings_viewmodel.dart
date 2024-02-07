import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/data/data_module.dart';
import 'package:flutter_weather_app/domain/models/settings_model.dart';
import 'package:flutter_weather_app/domain/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_weather_app/presentation/state/state.dart';

final settingsViewModelStateNotifierProvider =
    StateNotifierProvider.autoDispose<SettingsViewModel, State<SettingsModel>>(
  (ref) => SettingsViewModel(ref.watch(sharedPreferencesManagerProvider)),
);

class SettingsViewModel extends StateNotifier<State<SettingsModel>> {
  final SharedPreferencesManager _sharedPreferencesManager;

  SettingsViewModel(this._sharedPreferencesManager)
      : super(const State.init()) {
    getSelectedTheme();
  }

  void saveSelectedTheme(bool isDarkMode) async =>
      await _sharedPreferencesManager.setSelectedTheme(isDarkMode);

  getSelectedTheme() async {
    try {
      final result = await _sharedPreferencesManager.getSelectedTheme();
      state = State.success(
        SettingsModel(
          isDarkMode: result,
        ),
      );
    } on Exception catch (e) {
      state = State.error(e);
    }
  }
}

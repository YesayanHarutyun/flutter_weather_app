import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/domain/models/settings_model.dart';
import 'package:flutter_weather_app/presentation/state/state.dart';
import 'package:flutter_weather_app/presentation/viewmodel/settings_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../../mock/domain/sharedpreferences/shared_preferences_manager.mocks.dart';

void main() {
  late MockSharedPreferencesManager sharedPreferencesManager;

  late SettingsViewModel settingsViewModel;

  group("SettingsViewModelTests", () {
    setUp(() {
      sharedPreferencesManager = MockSharedPreferencesManager();

      when(sharedPreferencesManager.getSelectedTheme())
          .thenAnswer((_) async => true);

      settingsViewModel = SettingsViewModel(sharedPreferencesManager);
    });

    test("set selected theme", () async {
      settingsViewModel.saveSelectedTheme(true);

      verify(settingsViewModel.saveSelectedTheme(true)).called(1);
    });

    test("get selected theme - success", () async {
      await settingsViewModel.getSelectedTheme();

      settingsViewModel.addListener((state) {
        expect(state, const State.success(SettingsModel(isDarkMode: true)));
      });
    });

    test("get selected theme - error", () async {
      when(sharedPreferencesManager.getSelectedTheme())
          .thenAnswer((_) async => throw Exception(""));

      await settingsViewModel.getSelectedTheme();

      settingsViewModel.addListener((state) {
        expect(state.isError, true);
      });
    });
  });
}

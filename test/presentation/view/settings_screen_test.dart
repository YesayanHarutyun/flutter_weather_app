import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/domain/models/settings_model.dart';
import 'package:flutter_weather_app/presentation/apptheme/app_theme_provider.dart';
import 'package:flutter_weather_app/presentation/constants/strings.dart';
import 'package:flutter_weather_app/presentation/view/settings_screen.dart';
import 'package:flutter_weather_app/presentation/viewmodel/settings_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart' as provider;
import 'package:flutter_weather_app/presentation/state/state.dart' as ui_state;

import '../../mock/domain/sharedpreferences/shared_preferences_manager.mocks.dart';
import '../../mock/presentation/apptheme/mock_app_theme_provider.mocks.dart';

void main() {
  testWidgets('SettingsScreenTests', (WidgetTester tester) async {
    final mockSettingsViewModel = FakeSettingsViewModel();
    final mockAppThemeProvider = MockAppThemeProvider();

    when(mockAppThemeProvider.darkTheme).thenAnswer((_) => true);

    await tester.pumpWidget(
      provider.ChangeNotifierProvider<AppThemeProvider>(
        create: (_) => mockAppThemeProvider,
        child: ProviderScope(
          overrides: [
            settingsViewModelStateNotifierProvider
                .overrideWith((ref) => mockSettingsViewModel),
          ],
          child: MaterialApp(
            home: SettingsScreen(),
          ),
        ),
      ),
    );

    await tester.pump(Durations.short1);

    expect(find.text(Strings.aboutUs), findsOneWidget);
    expect(find.text(Strings.termsAndConditions), findsOneWidget);
    expect(find.text(Strings.darkTheme), findsOneWidget);
  });
}

class FakeSettingsViewModel extends SettingsViewModel {
  bool darkTheme = false;

  FakeSettingsViewModel() : super(MockSharedPreferencesManager());

  @override
  Future<void> saveSelectedTheme(bool value) async {
    darkTheme = value;
  }

  @override
  getSelectedTheme() {
    state = const ui_state.State.success(SettingsModel(isDarkMode: true));
  }
}

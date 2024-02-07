import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/navigation/navigation.dart';
import 'package:flutter_weather_app/navigation/weather_nav_screens.dart';
import 'package:flutter_weather_app/presentation/apptheme/app_theme_provider.dart';
import 'package:flutter_weather_app/presentation/constants/strings.dart';
import 'package:flutter_weather_app/presentation/view/favourite_cities_screen.dart';
import 'package:flutter_weather_app/presentation/view/home_screen.dart';
import 'package:flutter_weather_app/presentation/view/settings_screen.dart';
import 'package:mockito/mockito.dart';
import '../mock/presentation/apptheme/mock_app_theme_provider.mocks.dart';
import '../utils/setup_utils.dart';
import 'package:provider/provider.dart' as provider;

void main() {
  setUpAll(() {
    initSQFLite();
  });

  testWidgets("NavigationTests", (tester) async {
    final mockAppThemeProvider = MockAppThemeProvider();

    when(mockAppThemeProvider.darkTheme).thenReturn(true);

    await tester.pumpWidget(
      provider.ChangeNotifierProvider<AppThemeProvider>(
        create: (_) => mockAppThemeProvider,
        child: ProviderScope(
          // overrides: [],
          child: MaterialApp(
            home: MainNavigator(),
          ),
        ),
      ),
    );

    expect(find.byType(AppBar), findsOneWidget);
    expect(find.byType(BottomNavigationBar), findsOneWidget);
    expect(find.byType(HomeScreen), findsOneWidget);
    expect(find.text(Strings.home), findsOneWidget);
    expect(find.byKey(Key("${WeatherNavScreens.home.id}_checked")),
        findsOneWidget);

    await tester
        .tap(find.byKey(Key("${WeatherNavScreens.favourites.id}_unchecked")));
    await tester.pump(Durations.short1);

    expect(find.byType(FavouriteCitiesScreen), findsOneWidget);
    expect(find.text(Strings.favourites), findsOneWidget);
    expect(find.byKey(Key("${WeatherNavScreens.favourites.id}_checked")),
        findsOneWidget);

    await tester
        .tap(find.byKey(Key("${WeatherNavScreens.settings.id}_unchecked")));
    await tester.pump(Durations.short1);

    expect(find.byType(SettingsScreen), findsOneWidget);
    expect(find.text(Strings.settings), findsOneWidget);
    expect(find.byKey(Key("${WeatherNavScreens.settings.id}_checked")),
        findsOneWidget);
  });
}

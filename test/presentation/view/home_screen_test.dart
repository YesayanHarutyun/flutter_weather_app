import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_weather_app/domain/models/city_model.dart';
import 'package:flutter_weather_app/domain/models/suggested_cities_model.dart';
import 'package:flutter_weather_app/domain/models/weather_model.dart';
import 'package:flutter_weather_app/domain/models/weather_model_wrapper.dart';
import 'package:flutter_weather_app/domain/models/weather_request_model.dart';
import 'package:flutter_weather_app/presentation/apptheme/app_theme_provider.dart';
import 'package:flutter_weather_app/presentation/constants/strings.dart';
import 'package:flutter_weather_app/presentation/view/home_screen.dart';
import 'package:flutter_weather_app/presentation/viewmodel/home_screen_viewmodel.dart';
import 'package:mockito/mockito.dart';
import 'package:flutter_weather_app/presentation/state/state.dart' as ui_state;
import 'package:provider/provider.dart' as provider;
import '../../mock/domain/usecase/base_usecase_mock.mocks.dart';
import '../../mock/models/mock_models.dart';
import '../../mock/presentation/apptheme/mock_app_theme_provider.mocks.dart';
import '../../mock/presentation/viewmodel/favourite_cities_viewmodel_mock.mocks.dart';
import '../../utils/setup_utils.dart';
import '../../mock/utils/image_test_utils.dart';

main() {
  setUpAll(() => initSQFLite());

  testWidgets("HomeScreenTests", (tester) async {
    await mockNetworkImagesFor(() async {
      final fakeHomeViewModel = FakeHomeViewModel();
      final mockAppThemeProvider = MockAppThemeProvider();
      when(mockAppThemeProvider.darkTheme).thenReturn(true);

      await tester.pumpWidget(
        provider.ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => mockAppThemeProvider,
          child: ProviderScope(
            overrides: [
              homeViewModelStateNotifierProvider
                  .overrideWith((ref) => fakeHomeViewModel),
            ],
            child: MaterialApp(
              home: HomeScreen(),
            ),
          ),
        ),
      );

      await tester.pump(Durations.short1);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      fakeHomeViewModel.prepareError();

      await tester.pump(Durations.short1);

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text(Strings.somethingWentWrong), findsOneWidget);
      expect(find.byType(ElevatedButton), findsOneWidget);

      fakeHomeViewModel.prepareSuccess();

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(Durations.short1);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      await tester.pump(Durations.short1);

      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(TypeAheadField<SuggestedCitiesModel>), findsOneWidget);
      expect(find.byIcon(Icons.search), findsOneWidget);
      expect(find.text(Strings.searchCity), findsOneWidget);
      expect(find.text("New York"), findsOneWidget);
      expect(find.text("Light rain"), findsOneWidget);
      expect(find.text("${Strings.windDirection} 'SSE'"), findsOneWidget);
      expect(find.text("11.1${Strings.celsius}"), findsOneWidget);

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);

      await tester.tap(find.byIcon(Icons.favorite_border));
      await tester.pump(Durations.short2);

      expect(find.byIcon(Icons.favorite), findsOneWidget);

      await tester.ensureVisible(find.byIcon(Icons.favorite));
      await tester.pumpAndSettle();
      await tester.tap(find.byIcon(Icons.favorite));
      await tester.pump(Durations.short1);

      expect(find.byIcon(Icons.favorite_border), findsOneWidget);
    });
  });
}

class FakeHomeViewModel extends HomeViewModel {
  var _shouldThrowError = false;

  FakeHomeViewModel()
      : super(
          MockBaseUseCase<CityModel, bool>(),
          MockBaseUseCase<CityModel, bool>(),
          MockFavouriteCitiesViewModel(),
          MockBaseUseCase<String, List<SuggestedCitiesModel>>(),
          MockBaseUseCase<WeatherRequestModel, WeatherModel>(),
        );

  void prepareSuccess() => _shouldThrowError = false;

  void prepareError() => _shouldThrowError = true;

  @override
  Future<void> fetchWeatherByCity(bool isCurrent, String city) async {
    state = const ui_state.State.loading();

    await Future.delayed(Durations.short2);

    state = _shouldThrowError
        ? ui_state.State.error(
            Exception(""),
          )
        : ui_state.State.success(
            MockModels().createWeatherModelWrapper(),
          );
  }

  @override
  Future<Iterable<SuggestedCitiesModel>> fetchAutocompleteSearchCity(
      String suggestedKeyWord) {
    return Future.value(
      [
        const SuggestedCitiesModel(
          citySuggestion: "London",
          country: "UK",
        )
      ],
    );
  }

  @override
  addFavouriteCity(WeatherModel weatherModel) {
    state = _shouldThrowError
        ? ui_state.State.error(
            Exception(""),
          )
        : ui_state.State.success(
            WeatherModelWrapper(
              weatherModel: weatherModel.copyWith(isFavourite: true),
            ),
          );
  }

  @override
  deleteFavouriteCity(WeatherModel weatherModel) {
    state = _shouldThrowError
        ? ui_state.State.error(
            Exception(""),
          )
        : ui_state.State.success(
            WeatherModelWrapper(
              weatherModel: weatherModel.copyWith(isFavourite: false),
            ),
          );
  }

  @override
  void updateCurrentFavouriteState(bool isFavourite) {
    final data = state.data;
    if (data == null) return;
    state = _shouldThrowError
        ? ui_state.State.error(
            Exception(""),
          )
        : ui_state.State.success(
            WeatherModelWrapper(
              weatherModel: data.weatherModel.copyWith(isFavourite: false),
            ),
          );
  }

  @override
  void getFavouriteCities() {}
}

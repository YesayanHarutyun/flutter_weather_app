import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/domain/models/city_model.dart';
import 'package:flutter_weather_app/domain/models/forecast_model_wrapper.dart';
import 'package:flutter_weather_app/domain/models/weather_details_model_wrapper.dart';
import 'package:flutter_weather_app/domain/models/weather_model.dart';
import 'package:flutter_weather_app/domain/models/weather_request_model.dart';
import 'package:flutter_weather_app/presentation/apptheme/app_theme_provider.dart';
import 'package:flutter_weather_app/presentation/view/weather_detalis_screen.dart';
import 'package:flutter_weather_app/presentation/viewmodel/weather_details_viewmodel.dart';
import 'package:flutter_weather_app/presentation/state/state.dart' as ui_state;
import 'package:flutter_weather_app/utils/modify_forecast_models.dart';
import 'package:mockito/mockito.dart';
import 'package:provider/provider.dart' as provider;

import '../../mock/domain/usecase/base_usecase_mock.mocks.dart';
import '../../mock/models/mock_models.dart';
import '../../mock/presentation/apptheme/mock_app_theme_provider.mocks.dart';
import '../../mock/presentation/viewmodel/home_view_model_test.mocks.dart';
import '../../mock/utils/image_test_utils.dart';

const cityName = "London";

void main() {
  testWidgets("WeatherDetailsScreenTest", (tester) async {
    await mockNetworkImagesFor(() async {
      final mockAppThemeProvider = MockAppThemeProvider();
      final fakeWeatherDetailsViewModel = FakeWeatherDetailsViewModel();
      when(mockAppThemeProvider.darkTheme).thenReturn(true);

      await tester.pumpWidget(
        provider.ChangeNotifierProvider<AppThemeProvider>(
          create: (_) => mockAppThemeProvider,
          child: ProviderScope(
            overrides: [
              weatherDetailsViewModelStateNotifierProvider
                  .overrideWith((ref) => fakeWeatherDetailsViewModel),
            ],
            child: MaterialApp(
              home: WeatherDetailsScreen(cityName: cityName),
            ),
          ),
        ),
      );

      await tester.pump(Durations.short1);

      expect(find.byType(CircularProgressIndicator), findsOneWidget);

      fakeWeatherDetailsViewModel.prepareError();
    });
  });
}

class FakeWeatherDetailsViewModel extends WeatherDetailsViewModel {
  var _shouldThrowError = false;

  void prepareSuccess() => _shouldThrowError = false;

  void prepareError() => _shouldThrowError = true;

  final mockHomeViewModel = MockHomeViewModel();

  FakeWeatherDetailsViewModel()
      : super(
          MockBaseUseCase<String, ForecastModelWrapper>(),
          MockHomeViewModel(),
          cityName,
          MockBaseUseCase<WeatherRequestModel, WeatherModel>(),
          MockBaseUseCase<CityModel, bool>(),
          MockBaseUseCase<CityModel, bool>(),
        );

  @override
  Future<void> fetchWeatherByCity(String city) async {
    final modifiedForecastModelByHours = ModifyForecastModels()
        .modifyForecastModelByHours(
          MockModels.createForecastModelWrapper(),
        )
        .toList();
    final modifiedForecastModelByDays = ModifyForecastModels()
        .modifyForecastModelByDays(
          MockModels.createForecastModelWrapper(),
        )
        .toList();

    await Future.delayed(Durations.short1);

    state = _shouldThrowError
        ? ui_state.State.error(Exception(""))
        : ui_state.State.success(
            WeatherDetailsModelWrapper(
              weatherModel: MockModels.createWeatherModel(),
              forecastModelWrapper: ForecastModelWrapper(
                forecastModelByDays: modifiedForecastModelByDays,
                forecastModelByHours: modifiedForecastModelByHours,
              ),
            ),
          );
  }

  @override
  addFavouriteCity(WeatherModel weatherModel) {
    if (state.data == null) return;
    state = _shouldThrowError
        ? ui_state.State.error(Exception(""))
        : ui_state.State.success(
            state.data!.copyWith(
              weatherModel: weatherModel.copyWith(isFavourite: true),
            ),
          );
  }

  @override
  deleteFavouriteCity(WeatherModel weatherModel) {
    if (state.data == null) return;
    state = _shouldThrowError
        ? ui_state.State.error(Exception(""))
        : ui_state.State.success(
            state.data!.copyWith(
              weatherModel: weatherModel.copyWith(isFavourite: false),
            ),
          );
  }

  @override
  void updateCurrentFavouriteState(bool isFavourite) =>
      mockHomeViewModel.updateCurrentFavouriteState(isFavourite);

  @override
  void getFavouriteCities() {}
}

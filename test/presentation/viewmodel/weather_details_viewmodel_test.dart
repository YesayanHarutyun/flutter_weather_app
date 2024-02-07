import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/domain/models/city_model.dart';
import 'package:flutter_weather_app/domain/models/forecast_model_wrapper.dart';
import 'package:flutter_weather_app/domain/models/weather_details_model_wrapper.dart';
import 'package:flutter_weather_app/domain/models/weather_model.dart';
import 'package:flutter_weather_app/domain/models/weather_request_model.dart';
import 'package:flutter_weather_app/presentation/state/state.dart';
import 'package:flutter_weather_app/presentation/viewmodel/weather_details_viewmodel.dart';
import 'package:intl/intl.dart';
import 'package:mockito/mockito.dart';

import '../../mock/domain/usecase/base_usecase_mock.mocks.dart';
import '../../mock/models/mock_models.dart';
import '../../mock/presentation/viewmodel/home_view_model_test.mocks.dart';

void main() {
  late MockBaseUseCase<WeatherRequestModel, WeatherModel> fetchWeatherUseCase;

  late MockBaseUseCase<String, ForecastModelWrapper>
      fetchForecastWeatherByCityUseCase;

  late MockBaseUseCase<CityModel, bool> addFavouriteCityUseCase;

  late MockBaseUseCase<CityModel, bool> deleteFavouriteCityUseCase;

  late MockHomeViewModel homeViewModel;

  const String cityName = "London";

  late WeatherDetailsViewModel weatherDetailsViewModel;

  group("WeatherDetailsViewModelTests", () {
    const weatherModel = WeatherModel(
      city: "London",
      country: "United Kingdom",
      temperatureF: 52,
      temperatureC: 11.1,
      description: "Light rain",
      isFavourite: false,
      icon: "https://icon_url",
      windDir: "SSE",
    );

    final forecastModelWrapper = MockModels.createForecastModelWrapper();

    final modifiedForecastModelByHours =
        forecastModelWrapper.forecastModelByHours.map((e) {
      DateTime dateTime = DateTime.parse(e.date);
      String formattedDate = DateFormat('HH:mm').format(dateTime);
      return e.copyWith(date: formattedDate);
    }).toList();

    final modifiedForecastModelByDays =
        forecastModelWrapper.forecastModelByDays.map((e) {
      DateTime dateTime = DateTime.parse(e.date);
      String formattedDate = DateFormat('EEEE').format(dateTime);
      return e.copyWith(date: formattedDate);
    }).toList();

    setUp(() {
      fetchWeatherUseCase =
          MockBaseUseCase<WeatherRequestModel, WeatherModel>();
      fetchForecastWeatherByCityUseCase =
          MockBaseUseCase<String, ForecastModelWrapper>();
      addFavouriteCityUseCase = MockBaseUseCase<CityModel, bool>();
      deleteFavouriteCityUseCase = MockBaseUseCase<CityModel, bool>();
      homeViewModel = MockHomeViewModel();

      when(
        fetchWeatherUseCase.execute(
          input:
              const WeatherRequestModel(isCurrent: false, cityName: cityName),
        ),
      ).thenAnswer((_) async => weatherModel);

      when(
        fetchForecastWeatherByCityUseCase.execute(
          input: cityName,
        ),
      ).thenAnswer((_) async => forecastModelWrapper);

      weatherDetailsViewModel = WeatherDetailsViewModel(
          fetchForecastWeatherByCityUseCase,
          homeViewModel,
          cityName,
          fetchWeatherUseCase,
          addFavouriteCityUseCase,
          deleteFavouriteCityUseCase);
    });

    test("fetch weather by city - success", () async {
      await weatherDetailsViewModel.fetchWeatherByCity(cityName);
      weatherDetailsViewModel.addListener((state) {
        expect(
          state,
          State.success(
            WeatherDetailsModelWrapper(
              weatherModel: weatherModel,
              forecastModelWrapper: ForecastModelWrapper(
                forecastModelByDays: modifiedForecastModelByDays,
                forecastModelByHours: modifiedForecastModelByHours,
              ),
            ),
          ),
        );
      });
    });

    test("fetch weather by city - error", () async {
      when(
        fetchWeatherUseCase.execute(
          input:
              const WeatherRequestModel(isCurrent: false, cityName: cityName),
        ),
      ).thenAnswer((_) async => throw Exception(""));

      when(
        fetchForecastWeatherByCityUseCase.execute(
          input: cityName,
        ),
      ).thenAnswer((_) async => throw Exception(""));

      await weatherDetailsViewModel.fetchWeatherByCity(cityName);
      weatherDetailsViewModel.addListener((state) {
        expect(state.isError, true);
      });
    });

    test("add favourite city - success", () async {
      when(addFavouriteCityUseCase.execute(
              input: CityModel.fromWeatherModel(weatherModel)))
          .thenAnswer((_) async => true);

      await weatherDetailsViewModel.addFavouriteCity(weatherModel);

      weatherDetailsViewModel.addListener((state) {
        expect(
          state,
          State.success(
            WeatherDetailsModelWrapper(
              weatherModel: weatherModel.copyWith(isFavourite: true),
              forecastModelWrapper: ForecastModelWrapper(
                forecastModelByDays: modifiedForecastModelByDays,
                forecastModelByHours: modifiedForecastModelByHours,
              ),
            ),
          ),
        );
      });
    });

    test("add favourite city - error", () async {
      when(
        addFavouriteCityUseCase.execute(
          input: CityModel.fromWeatherModel(weatherModel),
        ),
      ).thenAnswer((_) async => throw Exception(""));

      await weatherDetailsViewModel.addFavouriteCity(weatherModel);

      weatherDetailsViewModel.addListener((state) {
        expect(state.isError, true);
      });
    });

    test("delete favourite city - success", () async {
      when(
        deleteFavouriteCityUseCase.execute(
          input: CityModel.fromWeatherModel(weatherModel),
        ),
      ).thenAnswer((_) async => true);

      await weatherDetailsViewModel.deleteFavouriteCity(weatherModel);

      weatherDetailsViewModel.addListener((state) {
        expect(
          state,
          State.success(
            WeatherDetailsModelWrapper(
              weatherModel: weatherModel.copyWith(isFavourite: false),
              forecastModelWrapper: ForecastModelWrapper(
                forecastModelByDays: modifiedForecastModelByDays,
                forecastModelByHours: modifiedForecastModelByHours,
              ),
            ),
          ),
        );
      });
    });

    test("delete favourite city - error", () async {
      when(
        deleteFavouriteCityUseCase.execute(
          input: CityModel.fromWeatherModel(weatherModel),
        ),
      ).thenAnswer((_) async => throw Exception(""));

      await weatherDetailsViewModel.deleteFavouriteCity(weatherModel);

      weatherDetailsViewModel.addListener((state) {
        expect(state.isError, true);
      });
    });

    test("update current favourite state", () {
      weatherDetailsViewModel.updateCurrentFavouriteState(true);

      verify(weatherDetailsViewModel.updateCurrentFavouriteState(true))
          .called(1);
    });
    test("get favourite cities", () {
      weatherDetailsViewModel.getFavouriteCities();

      verify(weatherDetailsViewModel.getFavouriteCities()).called(1);
    });
  });
}

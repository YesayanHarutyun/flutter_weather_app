import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/domain/models/city_model.dart';
import 'package:flutter_weather_app/domain/models/suggested_cities_model.dart';
import 'package:flutter_weather_app/domain/models/weather_model.dart';
import 'package:flutter_weather_app/domain/models/weather_model_wrapper.dart';
import 'package:flutter_weather_app/domain/models/weather_request_model.dart';
import 'package:flutter_weather_app/presentation/state/state.dart';
import 'package:flutter_weather_app/presentation/viewmodel/home_screen_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../../mock/domain/usecase/base_usecase_mock.mocks.dart';
import '../../mock/presentation/viewmodel/favourite_cities_viewmodel_mock.mocks.dart';

void main() {
  late MockBaseUseCase<WeatherRequestModel, WeatherModel> fetchWeatherUseCase;

  late MockBaseUseCase<CityModel, bool> addFavouriteCityUseCase;

  late MockBaseUseCase<CityModel, bool> deleteFavouriteCityUseCase;

  late MockBaseUseCase<String, List<SuggestedCitiesModel>>
      fetchAutoCompleteSearchCityUseCase;

  late MockFavouriteCitiesViewModel favouriteCitiesViewModel;

  late HomeViewModel homeViewModel;

  group('HomeScreenViewModelTests', () {
    const weatherModel = WeatherModel(
        city: "New York",
        country: "United States of America",
        temperatureF: 52,
        temperatureC: 11.1,
        description: "Light rain",
        isFavourite: false,
        icon: "https://icon_url",
        windDir: "SSE");

    const suggestedCitiesList = [
      SuggestedCitiesModel(citySuggestion: "London", country: "United Kingdom"),
      SuggestedCitiesModel(citySuggestion: "Londrina", country: "Brazil"),
      SuggestedCitiesModel(citySuggestion: "London", country: "Canada"),
      SuggestedCitiesModel(citySuggestion: "Londerzeel", country: "Belgium"),
      SuggestedCitiesModel(citySuggestion: "Londres", country: "Argentina"),
    ];

    setUp(() {
      fetchWeatherUseCase =
          MockBaseUseCase<WeatherRequestModel, WeatherModel>();
      addFavouriteCityUseCase = MockBaseUseCase<CityModel, bool>();
      deleteFavouriteCityUseCase = MockBaseUseCase<CityModel, bool>();
      fetchAutoCompleteSearchCityUseCase =
          MockBaseUseCase<String, List<SuggestedCitiesModel>>();
      favouriteCitiesViewModel = MockFavouriteCitiesViewModel();

      when(fetchWeatherUseCase.execute(
              input: const WeatherRequestModel(isCurrent: true, cityName: "")))
          .thenAnswer((_) async => Future.value(weatherModel));

      when(favouriteCitiesViewModel.loadFavouriteCities())
          .thenAnswer((_) async => Future.value());

      homeViewModel = HomeViewModel(
        addFavouriteCityUseCase,
        deleteFavouriteCityUseCase,
        favouriteCitiesViewModel,
        fetchAutoCompleteSearchCityUseCase,
        fetchWeatherUseCase,
      );
    });

    test("fetch weather by city - success", () async {
      when(fetchWeatherUseCase.execute(
              input: const WeatherRequestModel(
                  isCurrent: false, cityName: "New York")))
          .thenAnswer((_) async => Future.value(weatherModel));

      await homeViewModel.fetchWeatherByCity(false, "New York");

      homeViewModel.addListener((state) {
        expect(
          state,
          const State.success(
            WeatherModelWrapper(weatherModel: weatherModel),
          ),
        );
      });
    });

    test("fetch weather by city - error", () async {
      when(fetchWeatherUseCase.execute(
              input: const WeatherRequestModel(
                  isCurrent: false, cityName: "New York")))
          .thenAnswer((_) async => throw Exception(""));

      await homeViewModel.fetchWeatherByCity(false, "New York");

      homeViewModel.addListener((state) {
        expect(
          state.isError,
          true,
        );
      });
    });

    test("fetch autocomplete search city", () async {
      when(fetchAutoCompleteSearchCityUseCase.execute(input: "Lond"))
          .thenAnswer((_) async => suggestedCitiesList);
      final actual = await homeViewModel.fetchAutocompleteSearchCity("Lond");
      expect(actual, suggestedCitiesList);
    });

    test("add favourite city - success", () async {
      when(addFavouriteCityUseCase.execute(
              input: CityModel.fromWeatherModel(weatherModel)))
          .thenAnswer((_) async => true);

      await homeViewModel.addFavouriteCity(weatherModel);

      homeViewModel.addListener((state) {
        expect(
          state,
          State.success(
            WeatherModelWrapper(
              weatherModel: weatherModel.copyWith(isFavourite: true),
            ),
          ),
        );
      });
    });

    test("add favourite city - error", () async {
      when(addFavouriteCityUseCase.execute(
              input: CityModel.fromWeatherModel(weatherModel)))
          .thenAnswer((_) async => throw Exception(""));

      await homeViewModel.addFavouriteCity(weatherModel);

      homeViewModel.addListener((state) {
        expect(state.isError, true);
      });
    });

    test("delete favourite city - success", () async {
      when(deleteFavouriteCityUseCase.execute(
              input: CityModel.fromWeatherModel(weatherModel)))
          .thenAnswer((_) async => true);

      await homeViewModel.deleteFavouriteCity(weatherModel);

      homeViewModel.addListener((state) {
        expect(
          state,
          State.success(
            WeatherModelWrapper(
              weatherModel: weatherModel.copyWith(isFavourite: false),
            ),
          ),
        );
      });
    });

    test("delete favourite city - error", () async {
      when(deleteFavouriteCityUseCase.execute(
              input: CityModel.fromWeatherModel(weatherModel)))
          .thenAnswer((_) async => throw Exception(""));

      await homeViewModel.deleteFavouriteCity(weatherModel);

      homeViewModel.addListener((state) {
        expect(state.isError, true);
      });
    });

    test("update current favourite state - true", () {
      homeViewModel.updateCurrentFavouriteState(true);

      homeViewModel.addListener((state) {
        expect(state.data?.weatherModel.isFavourite, true);
      });
    });

    test("update current favourite state - false", () {
      homeViewModel.updateCurrentFavouriteState(false);

      homeViewModel.addListener((state) {
        expect(state.data?.weatherModel.isFavourite, false);
      });
    });

    test("get favourite cities", () {
      homeViewModel.getFavouriteCities();

      verify(favouriteCitiesViewModel.loadFavouriteCities()).called(1);
    });
  });
}

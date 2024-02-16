import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_weather_app/data/datasource/sharedpereferences/shared_preferences_manager_impl.dart';
import 'package:flutter_weather_app/domain/base/base_usecase.dart';
import 'package:flutter_weather_app/domain/domain_module.dart';
import 'package:flutter_weather_app/domain/models/city_model.dart';
import 'package:flutter_weather_app/domain/models/suggested_cities_model.dart';
import 'package:flutter_weather_app/domain/models/weather_model.dart';
import 'package:flutter_weather_app/domain/models/weather_model_wrapper.dart';
import 'package:flutter_weather_app/domain/models/weather_request_model.dart';
import 'package:flutter_weather_app/domain/sharedpreferences/shared_preferences_manager.dart';
import 'package:flutter_weather_app/presentation/state/state.dart';
import 'package:flutter_weather_app/presentation/viewmodel/favourite_cities_viewmodel.dart';

final homeViewModelStateNotifierProvider = StateNotifierProvider.autoDispose<
    HomeViewModel, State<WeatherModelWrapper>>(
  (ref) => HomeViewModel(
    ref.watch(addFavouriteWeatherByCityUseCaseProvider),
    ref.watch(deleteFavouriteWeatherByCityUseCaseProvider),
    ref.read(favouriteCitiesViewModelStateNotifierProvider.notifier),
    ref.watch(fetchAutoCompleteSearchCityUseCaseProvider),
    ref.watch(fetchWeatherUseCaseProvider),
  ),
);

class HomeViewModel extends StateNotifier<State<WeatherModelWrapper>> {
  final FavouriteCitiesViewModel _favouriteCitiesViewModel;
  final BaseUseCase<WeatherRequestModel, WeatherModel> _fetchWeatherUseCase;
  final BaseUseCase<CityModel, bool> _addFavouriteCityUseCase;
  final BaseUseCase<CityModel, bool> _deleteFavouriteCityUseCase;
  final BaseUseCase<String, List<SuggestedCitiesModel>>
      _fetchAutoCompleteSearchCityUseCase;

  SharedPreferencesManager cityNamePreference = SharedPreferencesManagerImpl();

  HomeViewModel(
    this._addFavouriteCityUseCase,
    this._deleteFavouriteCityUseCase,
    this._favouriteCitiesViewModel,
    this._fetchAutoCompleteSearchCityUseCase,
    this._fetchWeatherUseCase,
  ) : super(const State.init()) {
    checkAndUpdateWeatherBasedOnLocationPreference();
  }

  Future<void> checkAndUpdateWeatherBasedOnLocationPreference() async {
    final currentCityName = await cityNamePreference.getCurrentCity();
    currentCityName == null ? fetchWeatherByCity(true, "") : fetchWeatherByCity(false, currentCityName);
  }

  Future<void> fetchWeatherByCity(bool isCurrent, String cityName) async {
    try {
      cityNamePreference.setCurrentCity(cityName);
      state = const State.loading();
      final result = await _fetchWeatherUseCase.execute(
        input: WeatherRequestModel(
          isCurrent: isCurrent,
          cityName: cityName,
        ),
      );
      state = State.success(
        WeatherModelWrapper(weatherModel: result),
      );
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  Future<Iterable<SuggestedCitiesModel>> fetchAutocompleteSearchCity(
    String suggestedKeyWord,
  ) =>
      _fetchAutoCompleteSearchCityUseCase.execute(input: suggestedKeyWord);

  addFavouriteCity(WeatherModel weatherModel) async {
    try {
      final bool favouriteCity = await _addFavouriteCityUseCase.execute(
        input: CityModel.fromWeatherModel(weatherModel),
      );
      state = State.success(
        WeatherModelWrapper(
          weatherModel: weatherModel.copyWith(
            isFavourite: favouriteCity,
          ),
        ),
      );
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  deleteFavouriteCity(WeatherModel weatherModel) async {
    try {
      final bool isDeleted = await _deleteFavouriteCityUseCase.execute(
        input: CityModel.fromWeatherModel(weatherModel),
      );
      state = State.success(
        WeatherModelWrapper(
          weatherModel: weatherModel.copyWith(
            isFavourite: !isDeleted,
          ),
        ),
      );
    } on Exception catch (e) {
      state = State.error(e);
    }
  }

  void updateCurrentFavouriteState(bool isFavourite) {
    final data = state.data;
    if (data == null) return;
    state = State.success(
      WeatherModelWrapper(
        weatherModel: data.weatherModel.copyWith(isFavourite: isFavourite),
      ),
    );
  }

  void getFavouriteCities() {
    _favouriteCitiesViewModel.loadFavouriteCities();
  }
}

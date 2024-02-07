import 'package:flutter_weather_app/domain/base/base_usecase.dart';
import 'package:flutter_weather_app/domain/models/weather_request_model.dart';

import '../models/city_model.dart';
import '../models/weather_model.dart';

class FetchWeatherUseCase
    implements BaseUseCase<WeatherRequestModel, WeatherModel> {
  final BaseUseCase<WeatherRequestModel, WeatherModel>
      _fetchWeatherByCityUseCase;

  final BaseUseCase<String, CityModel?> _getCityByIdUseCase;

  const FetchWeatherUseCase(
      this._fetchWeatherByCityUseCase, this._getCityByIdUseCase);

  @override
  Future<WeatherModel> execute({required WeatherRequestModel input}) async {
    final WeatherModel weather =
        await _fetchWeatherByCityUseCase.execute(input: input);

    final String cityId = "${weather.city}_${weather.country}";
    final cityModel = await _getCityByIdUseCase.execute(input: cityId);
    final isCityFavorite = weather.country == cityModel?.country &&
        weather.city == cityModel?.city;

    return weather.copyWith(isFavourite: isCityFavorite);
  }
}

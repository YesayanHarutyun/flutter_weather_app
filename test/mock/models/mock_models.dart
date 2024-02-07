import 'package:flutter_weather_app/domain/models/forecast_info_model.dart';
import 'package:flutter_weather_app/domain/models/forecast_model_by_days.dart';
import 'package:flutter_weather_app/domain/models/forecast_model_by_hours.dart';
import 'package:flutter_weather_app/domain/models/forecast_model_wrapper.dart';
import 'package:flutter_weather_app/domain/models/weather_details_model_wrapper.dart';
import 'package:flutter_weather_app/domain/models/weather_model.dart';
import 'package:flutter_weather_app/domain/models/weather_model_wrapper.dart';

class MockModels {

  static WeatherModel createWeatherModel() =>
      const WeatherModel(
          city: "New York",
          country: "United States of America",
          temperatureF: 52,
          temperatureC: 11.1,
          description: "Light rain",
          isFavourite: false,
          icon: "https://icon_url",
          windDir: "SSE");
  WeatherModelWrapper createWeatherModelWrapper() =>
      WeatherModelWrapper(weatherModel: createWeatherModel());

  static ForecastModelWrapper createForecastModelWrapper() =>
      const ForecastModelWrapper(
        forecastModelByDays: [
          ForecastModelByDays(
            date: "2022-01-01 00:00",
            forecastInfoModel: ForecastInfoModel(
              icon: "https://icon_url",
              temperature: 19.4,
            ),
            description: "Partly cloudy",
          ),
          ForecastModelByDays(
            date: "2022-01-01 01:00",
            forecastInfoModel: ForecastInfoModel(
              icon: "https://icon_url",
              temperature: 20.5,
            ),
            description: "Sunny",
          ),
          ForecastModelByDays(
            date: "2022-01-01 02:00",
            forecastInfoModel: ForecastInfoModel(
              icon: "https://icon_url",
              temperature: 21.6,
            ),
            description: "Rainy",
          ),
        ],
        forecastModelByHours: [
          ForecastModelByHours(
            date: "2022-01-01 00:00",
            forecastInfoModel: ForecastInfoModel(
              icon: "https://icon_url",
              temperature: 16.1,
            ),
          ),
          ForecastModelByHours(
            date: "2022-01-01 01:00",
            forecastInfoModel: ForecastInfoModel(
              icon: "https://icon_url",
              temperature: 17.2,
            ),
          ),
          ForecastModelByHours(
            date: "2022-01-01 02:00",
            forecastInfoModel: ForecastInfoModel(
              icon: "https://icon_url",
              temperature: 18.3,
            ),
          ),
        ],
      );

  static WeatherDetailsModelWrapper createWeatherDetailsModelWrapper() =>
      WeatherDetailsModelWrapper(weatherModel: createWeatherModel(), forecastModelWrapper: createForecastModelWrapper());
}
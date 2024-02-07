import 'package:flutter_weather_app/domain/models/forecast_model_by_days.dart';
import 'package:flutter_weather_app/domain/models/forecast_model_by_hours.dart';
import 'package:flutter_weather_app/domain/models/forecast_model_wrapper.dart';
import 'package:intl/intl.dart';

class ModifyForecastModels {
  Iterable<ForecastModelByDays> modifyForecastModelByDays(
          ForecastModelWrapper forecastModelWrapper) =>
      forecastModelWrapper.forecastModelByDays.map((e) {
        DateTime dateTime = DateTime.parse(e.date);
        String formattedDate = DateFormat('EEEE').format(dateTime);
        return e.copyWith(date: formattedDate);
      });

  Iterable<ForecastModelByHours> modifyForecastModelByHours(
          ForecastModelWrapper forecastModelWrapper) =>
      forecastModelWrapper.forecastModelByHours.map((e) {
        DateTime dateTime = DateTime.parse(e.date);
        String formattedDate = DateFormat('HH:mm').format(dateTime);
        return e.copyWith(date: formattedDate);
      });
}

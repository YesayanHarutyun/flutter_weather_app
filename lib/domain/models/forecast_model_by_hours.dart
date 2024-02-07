import 'package:flutter_weather_app/domain/models/forecast_info_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'forecast_model_by_hours.freezed.dart';

@freezed
class ForecastModelByHours with _$ForecastModelByHours {
  const factory ForecastModelByHours({
    required String date,
    required ForecastInfoModel forecastInfoModel,
  }) = _ForecastModelByHours;

  const ForecastModelByHours._();
}

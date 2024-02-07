import 'package:freezed_annotation/freezed_annotation.dart';

part 'weather_request_model.freezed.dart';

@freezed
class WeatherRequestModel with _$WeatherRequestModel {
  const factory WeatherRequestModel({
  required bool isCurrent,
  required String cityName,
}) = _WeatherRequestModel;
}
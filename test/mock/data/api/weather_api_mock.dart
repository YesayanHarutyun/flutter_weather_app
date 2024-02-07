import 'dart:io';

import 'package:flutter_weather_app/data/api/weather_api.dart';
import 'package:mockito/annotations.dart';

@GenerateMocks([
  WeatherApi,
  HttpClient,
  HttpClientRequest,
  HttpClientResponse,
  HttpHeaders,
])
void main() {}

import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/domain/base/base_usecase.dart';
import 'package:flutter_weather_app/domain/models/forecast_model_wrapper.dart';
import 'package:flutter_weather_app/domain/repository/weather_repository.dart';
import 'package:flutter_weather_app/domain/usecase/fetch_forecast_usecase.dart';
import 'package:mockito/mockito.dart';

import '../mock/domain/repository/weather_repository_mock.mocks.dart';
import '../mock/models/mock_models.dart';

void main() {
  final WeatherRepository weatherRepository = MockWeatherRepository();
  final BaseUseCase<String, ForecastModelWrapper> fetchForecastUseCase =
      FetchForecastUseCase(weatherRepository);

  setUp(() {
    when(weatherRepository.fetchForecastWeatherByCity("London")).thenAnswer(
      (_) async => MockModels.createForecastModelWrapper(),
    );
  });

  test('should return ForecastModelWrapper', () async {
    final actual = await fetchForecastUseCase.execute(input: "London");
    final expected = MockModels.createForecastModelWrapper();
    expect(expected, actual);
    verify(weatherRepository.fetchForecastWeatherByCity("London")).called(1);
  });
}

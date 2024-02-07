import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/domain/models/cities_list_model.dart';
import 'package:flutter_weather_app/domain/models/city_model.dart';
import 'package:flutter_weather_app/domain/models/empty_input.dart';
import 'package:flutter_weather_app/presentation/state/state.dart';
import 'package:flutter_weather_app/presentation/viewmodel/favourite_cities_viewmodel.dart';
import 'package:mockito/mockito.dart';

import '../../mock/domain/usecase/base_usecase_mock.mocks.dart';

void main() {
  late MockBaseUseCase<CityModel, bool> deleteFavouriteCityUseCase;

  late MockBaseUseCase<EmptyInput, CitiesListModel>
      getFavouriteCitiesListUseCase;

  late FavouriteCitiesViewModel favouriteCitiesViewModel;

  group(
    "FavouriteCitiesViewModelTests",
    () {
      const expectedCitiesListModel = CitiesListModel(
        cityModelList: [
          CityModel(city: "Chicago", country: "USA"),
          CityModel(city: "Zanzibar", country: "Tanzania"),
          CityModel(city: "Beijing", country: "China"),
          CityModel(city: "Porto", country: "Portugal"),
        ],
      );
      const cityModel = CityModel(city: "Chicago", country: "USA");

      setUp(() {
        deleteFavouriteCityUseCase = MockBaseUseCase<CityModel, bool>();
        getFavouriteCitiesListUseCase =
            MockBaseUseCase<EmptyInput, CitiesListModel>();

        when(getFavouriteCitiesListUseCase.execute(input: const EmptyInput()))
            .thenAnswer((_) async => Future.value(expectedCitiesListModel));

        favouriteCitiesViewModel = FavouriteCitiesViewModel(
            deleteFavouriteCityUseCase, getFavouriteCitiesListUseCase);
      });

      test('load favourite cities - success', () async {
        await favouriteCitiesViewModel.loadFavouriteCities();

        favouriteCitiesViewModel.addListener((state) {
          expect(state, const State.success(expectedCitiesListModel));
        });
      });

      test('load favourite cities - error', () async {
        when(getFavouriteCitiesListUseCase.execute(input: const EmptyInput()))
            .thenAnswer((_) async => throw Exception(""));

        await favouriteCitiesViewModel.loadFavouriteCities();

        favouriteCitiesViewModel.addListener((state) {
          expect(state.isError, true);
        });
      });

      test('delete favourite city - success', () async {
        when(deleteFavouriteCityUseCase.execute(input: cityModel)).thenAnswer(
          (_) async => Future.value(true),
        );

        await favouriteCitiesViewModel.deleteFavouriteCity(cityModel);

        favouriteCitiesViewModel.addListener((state) {
          expect(
            state,
            const State.success(
              CitiesListModel(
                cityModelList: [
                  CityModel(city: "Zanzibar", country: "Tanzania"),
                  CityModel(city: "Beijing", country: "China"),
                  CityModel(city: "Porto", country: "Portugal"),
                ],
              ),
            ),
          );
        });
      });

      test('delete favourite city - error', () async {
        when(
          deleteFavouriteCityUseCase.execute(
            input: cityModel,
          ),
        ).thenAnswer(
          (_) async => throw Exception(""),
        );

        await favouriteCitiesViewModel.deleteFavouriteCity(cityModel);

        favouriteCitiesViewModel.addListener((state) {
          expect(state.isError, true);
        });
      });
    },
  );
}

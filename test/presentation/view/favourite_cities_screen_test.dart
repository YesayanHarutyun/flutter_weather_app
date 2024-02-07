import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_weather_app/domain/models/cities_list_model.dart';
import 'package:flutter_weather_app/domain/models/city_model.dart';
import 'package:flutter_weather_app/domain/models/empty_input.dart';
import 'package:flutter_weather_app/presentation/constants/strings.dart';
import 'package:flutter_weather_app/presentation/view/favourite_cities_screen.dart';
import 'package:flutter_weather_app/presentation/viewmodel/favourite_cities_viewmodel.dart';
import 'package:flutter_weather_app/presentation/state/state.dart' as ui_state;

import '../../mock/domain/usecase/base_usecase_mock.mocks.dart';
import '../../utils/setup_utils.dart';

void main() {
  setUpAll(() => initSQFLite());

  testWidgets("FavouriteCitiesScreenTest", (tester) async {
    final fakeFavouriteCitiesViewModel = FakeFavouriteCitiesViewModel();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          favouriteCitiesViewModelStateNotifierProvider
              .overrideWith((ref) => fakeFavouriteCitiesViewModel),
        ],
        child: MaterialApp(
          home: FavouriteCitiesScreen(),
        ),
      ),
    );

    await tester.pump(Durations.short1);

    fakeFavouriteCitiesViewModel.prepareSuccess();

    expect(find.text("New York"), findsOneWidget);
    expect(find.text("Beijing"), findsOneWidget);
    expect(find.text("Berlin"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite).first);
    await tester.pump(Durations.short1);

    expect(find.text("New York"), findsNothing);
    expect(find.text("Beijing"), findsOneWidget);
    expect(find.text("Berlin"), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite).first);
    await tester.pump(Durations.short1);

    expect(find.text("Beijing"), findsNothing);
    expect(find.text("Berlin"), findsOneWidget);
    expect(find.byIcon(Icons.favorite), findsOneWidget);

    await tester.tap(find.byIcon(Icons.favorite).first);
    await tester.pump(Durations.short1);

    expect(find.text("Berlin"), findsNothing);
    expect(find.byIcon(Icons.favorite), findsNothing);
    expect(find.text(Strings.thereIsNoFavouriteCity), findsOneWidget,);
  });
}

class FakeFavouriteCitiesViewModel extends FavouriteCitiesViewModel {
  var _shouldThrowError = false;

  void prepareSuccess() => _shouldThrowError = false;

  void prepareError() => _shouldThrowError = true;

  FakeFavouriteCitiesViewModel()
      : super(
          MockBaseUseCase<CityModel, bool>(),
          MockBaseUseCase<EmptyInput, CitiesListModel>(),
        );

  @override
  Future<void> loadFavouriteCities() async {
    await Future.delayed(Durations.short1);

    state = _shouldThrowError
        ? ui_state.State.error(Exception(""))
        : const ui_state.State.success(
            CitiesListModel(
              cityModelList: [
                CityModel(city: "New York", country: "United States of America"),
                CityModel(city: "Beijing", country: "China"),
                CityModel(city: "Berlin", country: "Germany")
              ],
            ),
          );
  }

  @override
  deleteFavouriteCity(CityModel cityModel) async {
    final currentData = state.data ?? const CitiesListModel(cityModelList: []);
    final currentList = currentData.cityModelList.toList();
    await Future.delayed(Durations.short1);

    int index = -1;
    for (int i = 0; i < currentList.length; i++) {
      if (currentList[i].id == cityModel.id) {
        index = i;
        break;
      }
    }

    if (index >= 0) currentList.removeAt(index);

    state = _shouldThrowError
        ? ui_state.State.error(Exception(""))
        : ui_state.State.success(
            currentData.copyWith(cityModelList: currentList));
  }
}

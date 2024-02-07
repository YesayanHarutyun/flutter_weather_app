import 'package:flutter_weather_app/data/mappers/db/city_entity_mapper.dart';
import 'package:flutter_weather_app/data/models/dao/city_model_dao.dart';
import 'package:flutter_weather_app/domain/models/cities_list_model.dart';

class CitiesListEntityMapper {
  static CitiesListModel transformCitiesListModelDaoToDomain(
      final CitiesListModelDao citiesListEntity) {
    final citiesListModelMap = citiesListEntity
        .map((entity) => CityEntityMapper.transformCityModelDaoToDomain(entity))
        .toList();
    return CitiesListModel(cityModelList: citiesListModelMap);
  }

  static CitiesListModelDao transformToData(final CitiesListModel model) =>
      model.cityModelList
          .map((value) => CityEntityMapper.transformToData(value))
          .toList();
}

import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/features/feature_bookmark/domain/entities/city_entity.dart';

abstract class CityRepository {
  Future<DataState<City>> saveCityToDB(String cityName);

  Future<DataState<List<City>>> getAllCityFromDB();

  Future<DataState<City?>> findCityByName(String name);

  Future<DataState<String>> deleteCityByName(String name);
}

import 'package:hiit/core/params/forecast_params.dart';
import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:hiit/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:hiit/features/feature_weather/domain/entities/forecast_hourly_entity.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWetherData(String cityName);
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherLocation(
      ForecastParams params);
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForecastParams params);
  Future<DataState<ForecastHourlyEntity>> fetchForecastHourlyData(
      ForecastParams params);
  Future<List<Data>> fetchSuggestData(cityName);
}

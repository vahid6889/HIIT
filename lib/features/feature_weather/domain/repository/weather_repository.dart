import 'package:Hiit/core/params/forecast_params.dart';
import 'package:Hiit/core/resources/data_state.dart';
import 'package:Hiit/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_air_quality_city_entity.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:Hiit/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:Hiit/features/feature_weather/domain/entities/forecast_hourly_entity.dart';

abstract class WeatherRepository {
  Future<DataState<CurrentCityEntity>> fetchCurrentWetherData(String cityName);
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherLocation(
      ForecastParams params);
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForecastParams params);
  Future<DataState<ForecastHourlyEntity>> fetchForecastHourlyData(
      ForecastParams params);
  Future<List<Data>> fetchSuggestData(cityName);
  Future<DataState<CurrentAirQualityCityEntity>> fetchCurrentAirQualityCity(
      ForecastParams params);
}

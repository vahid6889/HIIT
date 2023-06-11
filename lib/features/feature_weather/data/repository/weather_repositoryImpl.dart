import 'package:hiit/core/error_handling/app_exception.dart';
import 'package:hiit/core/error_handling/check_exceptions.dart';
import 'package:hiit/core/params/forecast_params.dart';
import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:hiit/features/feature_weather/data/models/current_air_quality_city_model.dart';
import 'package:hiit/features/feature_weather/data/models/current_city_model.dart';
import 'package:hiit/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:hiit/features/feature_weather/data/models/forecast_hourly_model.dart';
import 'package:hiit/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:hiit/features/feature_weather/domain/entities/current_air_quality_city_entity.dart';
import 'package:hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:hiit/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:hiit/features/feature_weather/domain/entities/forecast_hourly_entity.dart';
import 'package:hiit/features/feature_weather/domain/entities/suggest_city_entity.dart';
import 'package:hiit/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:dio/dio.dart';

class WeatherRepositoryImpl extends WeatherRepository {
  final ApiProvider _apiProvider;

  WeatherRepositoryImpl(this._apiProvider);

  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWetherData(
      String cityName) async {
    try {
      Response response = await _apiProvider.callCurrentWeather(cityName);

      CurrentCityEntity currentCityEntity =
          CurrentCityModel.fromJson(response.data);
      return DataSuccess(currentCityEntity);
    } on AppException catch (e) {
      return await CheckExceptions.getError(e);
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForecastParams params) async {
    try {
      Response response = await _apiProvider.sendRequest7DaysForcast(params);

      ForecastDaysEntity forecastDaysEntity =
          ForecastDaysModel.fromJson(response.data);
      return DataSuccess(forecastDaysEntity);
    } on AppException catch (e) {
      print('FOOOOOOOOOORRRRRRR');
      return await CheckExceptions.getError(e.message);
    }
  }

  @override
  Future<DataState<ForecastHourlyEntity>> fetchForecastHourlyData(
      ForecastParams params) async {
    try {
      Response response = await _apiProvider.sendRequest48HoursForcast(params);

      ForecastHourlyEntity forecastHourlyEntity =
          ForecastHourlyModel.fromJson(response.data);

      return DataSuccess(forecastHourlyEntity);
    } on AppException catch (e) {
      return await CheckExceptions.getError(e);
    }
  }

  @override
  Future<List<Data>> fetchSuggestData(cityName) async {
    try {
      Response response =
          await _apiProvider.sendRequestCitySuggestion(cityName);
      SuggestCityEntity suggestCityEntity =
          SuggestCityModel.fromJson(response.data);

      return suggestCityEntity.data!;
    } on AppException catch (e) {
      return await CheckExceptions.getError(e);
    }
  }

  @override
  Future<DataState<CurrentCityEntity>> fetchCurrentWeatherLocation(
      ForecastParams params) async {
    try {
      Response response = await _apiProvider.callCurrentWeatherLocation(params);

      CurrentCityEntity currentCityEntity =
          CurrentCityModel.fromJson(response.data);
      return DataSuccess(currentCityEntity);
    } on AppException catch (e) {
      return await CheckExceptions.getError(e);
    }
  }

  @override
  Future<DataState<CurrentAirQualityCityEntity>> fetchCurrentAirQualityCity(
      ForecastParams params) async {
    try {
      Response response = await _apiProvider.callCurrentAirQualityCity(params);

      CurrentAirQualityCityEntity currentAirQualityCityEntity =
          CurrentAirQualityCityModel.fromJson(response.data);
      return DataSuccess(currentAirQualityCityEntity);
    } on AppException catch (e) {
      return await CheckExceptions.getError(e);
    }
  }
}

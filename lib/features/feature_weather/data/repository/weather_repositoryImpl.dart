import 'package:hiit/core/params/forecast_params.dart';
import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:hiit/features/feature_weather/data/models/current_city_model.dart';
import 'package:hiit/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:hiit/features/feature_weather/data/models/forecast_hourly_model.dart';
import 'package:hiit/features/feature_weather/data/models/suggest_city_model.dart';
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

      if (response.statusCode == 200) {
        CurrentCityEntity currentCityEntity =
            CurrentCityModel.fromJson(response.data);
        return DataSuccess(currentCityEntity);
      } else {
        return const DataFailed("Something Went Wrong. try again ...");
      }
    } catch (e) {
      return const DataFailed("Please check connection ...");
    }
  }

  @override
  Future<DataState<ForecastDaysEntity>> fetchForecastWeatherData(
      ForecastParams params) async {
    try {
      Response response = await _apiProvider.sendRequest7DaysForcast(params);

      if (response.statusCode == 200) {
        ForecastDaysEntity forecastDaysEntity =
            ForecastDaysModel.fromJson(response.data);
        return DataSuccess(forecastDaysEntity);
      } else {
        return const DataFailed("Something Went Wrong. try again...");
      }
    } catch (e) {
      // print(e.toString());
      return const DataFailed("please check your connection...");
    }
  }

  @override
  Future<DataState<ForecastHourlyEntity>> fetchForecastHourlyData(
      ForecastParams params) async {
    try {
      Response response = await _apiProvider.sendRequest48HoursForcast(params);

      if (response.statusCode == 200) {
        ForecastHourlyEntity forecastHourlyEntity =
            ForecastHourlyModel.fromJson(response.data);

        return DataSuccess(forecastHourlyEntity);
      } else {
        return const DataFailed("Something Went Wrong. try again...");
      }
    } catch (e) {
      print(e);
      return const DataFailed("please check your connection...");
    }
  }

  @override
  Future<List<Data>> fetchSuggestData(cityName) async {
    Response response = await _apiProvider.sendRequestCitySuggestion(cityName);
    SuggestCityEntity suggestCityEntity =
        SuggestCityModel.fromJson(response.data);

    return suggestCityEntity.data!;
  }
}

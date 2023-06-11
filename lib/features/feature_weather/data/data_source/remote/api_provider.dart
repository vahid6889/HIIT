import 'package:Hiit/core/error_handling/check_exceptions.dart';
import 'package:Hiit/core/utils/constants.dart';
import 'package:dio/dio.dart';
import 'package:Hiit/core/params/forecast_params.dart';

class ApiProvider {
  final Dio _dio = Dio();

  var apiKey = Constants.apiKeys1;

  /// current weather api
  Future<dynamic> callCurrentWeather(cityname) async {
    try {
      var response = await _dio
          .get("${Constants.baseUrl}/data/2.5/weather", queryParameters: {
        'q': cityname,
        'appid': apiKey,
        'units': 'metric',
      });
      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  /// current weather api with lat & lon location
  Future<dynamic> callCurrentWeatherLocation(ForecastParams params) async {
    try {
      var response = await _dio
          .get("${Constants.baseUrl}/data/2.5/weather", queryParameters: {
        'lat': params.lat,
        'lon': params.lon,
        'appid': apiKey,
        'units': 'metric',
      });
      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  /// 7 days forecast api
  Future<dynamic> sendRequest7DaysForcast(ForecastParams params) async {
    try {
      var response = await _dio
          .get("${Constants.baseUrl}/data/2.5/onecall", queryParameters: {
        'lat': params.lat,
        'lon': params.lon,
        'exclude': 'minutely,hourly',
        'appid': apiKey,
        'units': 'metric'
      });

      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  /// hourly forecast for 48 hours
  Future<dynamic> sendRequest48HoursForcast(ForecastParams params) async {
    try {
      var response = await _dio
          .get("${Constants.baseUrl}/data/2.5/onecall", queryParameters: {
        'lat': params.lat,
        'lon': params.lon,
        'exclude': 'current,minutely,daily',
        'appid': apiKey,
        'units': 'metric'
      });

      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  /// city name suggest api
  Future<dynamic> sendRequestCitySuggestion(String prefix) async {
    try {
      var response = await _dio.get(
          "http://geodb-free-service.wirefreethought.com/v1/geo/cities",
          queryParameters: {'limit': 7, 'offset': 0, 'namePrefix': prefix});

      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }

  /// current weather api with lat & lon location
  Future<dynamic> callCurrentAirQualityCity(ForecastParams params) async {
    try {
      var response = await _dio
          .get("${Constants.baseUrl}/data/2.5/air_pollution", queryParameters: {
        'lat': params.lat,
        'lon': params.lon,
        'appid': apiKey,
      });
      return response;
    } on DioError catch (e) {
      return CheckExceptions.response(e.response!);
    }
  }
}

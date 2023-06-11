import 'package:Hiit/core/utils/prefs_operator.dart';
import 'package:Hiit/features/feature_bookmark/data/data_source/local/database.dart';
import 'package:Hiit/features/feature_bookmark/data/repository/city_repositoryimpl.dart';
import 'package:Hiit/features/feature_bookmark/domain/repository/city_repository.dart';
import 'package:Hiit/features/feature_bookmark/domain/use_cases/delete_city_usecase.dart';
import 'package:Hiit/features/feature_bookmark/domain/use_cases/get_all_city_usecase.dart';
import 'package:Hiit/features/feature_bookmark/domain/use_cases/get_city_usecase.dart';
import 'package:Hiit/features/feature_bookmark/domain/use_cases/save_city_usecase.dart';
import 'package:Hiit/features/feature_bookmark/presentation/bloc/bookmark_bloc.dart';
import 'package:Hiit/features/feature_weather/data/data_source/remote/api_provider.dart';
import 'package:Hiit/features/feature_weather/data/repository/weather_repositoryImpl.dart';
import 'package:Hiit/features/feature_weather/domain/repository/weather_repository.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_current_air_quality_city_usecase.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_current_weather_location_usecase.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_current_weather_usecase.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_forecast_hourly_usecase.dart';
import 'package:Hiit/features/feature_weather/domain/use_cases/get_forecast_weather_usecase.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/home_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

GetIt locator = GetIt.instance;

setup() async {
  locator.registerSingleton<ApiProvider>(ApiProvider());

  final database =
      await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  locator.registerSingleton<AppDatabase>(database);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  locator.registerSingleton<SharedPreferences>(sharedPreferences);
  locator.registerSingleton<PrefsOperator>(PrefsOperator());

  /// repositories
  locator
      .registerSingleton<WeatherRepository>(WeatherRepositoryImpl(locator()));
  locator
      .registerSingleton<CityRepository>(CityRepositoryImpl(database.cityDao));

  /// use case
  locator.registerSingleton<GetCurrentWeatherUseCase>(
      GetCurrentWeatherUseCase(locator()));
  locator.registerSingleton<GetCurrentWeatherLocationUseCase>(
      GetCurrentWeatherLocationUseCase(locator()));
  locator.registerSingleton<GetForecastWeatherUseCase>(
      GetForecastWeatherUseCase(locator()));
  locator.registerSingleton<GetForecastHourlyUseCase>(
      GetForecastHourlyUseCase(locator()));
  locator.registerSingleton<GetCityUseCase>(GetCityUseCase(locator()));
  locator.registerSingleton<SaveCityUseCase>(SaveCityUseCase(locator()));
  locator.registerSingleton<GetAllCityUseCase>(GetAllCityUseCase(locator()));
  locator.registerSingleton<DeleteCityUseCase>(DeleteCityUseCase(locator()));
  locator.registerSingleton<GetCurrentAirQualityCityUsecase>(
      GetCurrentAirQualityCityUsecase(locator()));

  locator.registerSingleton(
      HomeBloc(locator(), locator(), locator(), locator(), locator()));
  locator.registerSingleton(
      BookmarkBloc(locator(), locator(), locator(), locator()));
}

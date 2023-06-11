import 'package:Hiit/core/params/forecast_params.dart';
import 'package:Hiit/core/resources/data_state.dart';
import 'package:Hiit/core/usecase/use_case.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:Hiit/features/feature_weather/domain/repository/weather_repository.dart';

class GetCurrentWeatherLocationUseCase
    implements UseCase<DataState<CurrentCityEntity>, ForecastParams> {
  final WeatherRepository weatherRepository;

  GetCurrentWeatherLocationUseCase(this.weatherRepository);

  @override
  Future<DataState<CurrentCityEntity>> call(ForecastParams params) {
    return weatherRepository.fetchCurrentWeatherLocation(params);
  }
}

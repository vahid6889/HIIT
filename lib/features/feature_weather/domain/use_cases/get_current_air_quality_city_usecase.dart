import 'package:Hiit/core/params/forecast_params.dart';
import 'package:Hiit/core/resources/data_state.dart';
import 'package:Hiit/core/usecase/use_case.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_air_quality_city_entity.dart';
import 'package:Hiit/features/feature_weather/domain/repository/weather_repository.dart';

class GetCurrentAirQualityCityUsecase
    implements UseCase<DataState<CurrentAirQualityCityEntity>, ForecastParams> {
  final WeatherRepository weatherRepository;

  GetCurrentAirQualityCityUsecase(this.weatherRepository);

  @override
  Future<DataState<CurrentAirQualityCityEntity>> call(ForecastParams params) {
    return weatherRepository.fetchCurrentAirQualityCity(params);
  }
}

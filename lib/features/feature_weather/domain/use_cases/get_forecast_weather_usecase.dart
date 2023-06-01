import 'package:hiit/core/params/forecast_params.dart';
import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/core/usecase/use_case.dart';
import 'package:hiit/features/feature_weather/domain/entities/forecase_days_entity.dart';
import 'package:hiit/features/feature_weather/domain/repository/weather_repository.dart';

class GetForecastWeatherUseCase
    implements UseCase<DataState<ForecastDaysEntity>, ForecastParams> {
  final WeatherRepository _weatherRepository;
  GetForecastWeatherUseCase(this._weatherRepository);

  @override
  Future<DataState<ForecastDaysEntity>> call(ForecastParams params) {
    return _weatherRepository.fetchForecastWeatherData(params);
  }
}

import 'package:hiit/core/params/forecast_params.dart';
import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/core/usecase/use_case.dart';
import 'package:hiit/features/feature_weather/domain/entities/forecast_hourly_entity.dart';
import 'package:hiit/features/feature_weather/domain/repository/weather_repository.dart';

class GetForecastHourlyUseCase
    implements UseCase<DataState<ForecastHourlyEntity>, ForecastParams> {
  final WeatherRepository _weatherRepository;
  GetForecastHourlyUseCase(this._weatherRepository);

  @override
  Future<DataState<ForecastHourlyEntity>> call(ForecastParams params) {
    return _weatherRepository.fetchForecastHourlyData(params);
  }
}

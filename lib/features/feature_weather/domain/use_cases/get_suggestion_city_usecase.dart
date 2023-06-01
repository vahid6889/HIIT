import 'package:hiit/core/usecase/use_case.dart';
import 'package:hiit/features/feature_weather/data/models/suggest_city_model.dart';
import 'package:hiit/features/feature_weather/domain/repository/weather_repository.dart';

class GetSuggestionCityUseCase implements UseCase<List<Data>, String> {
  final WeatherRepository _weatherRepository;
  GetSuggestionCityUseCase(this._weatherRepository);

  @override
  Future<List<Data>> call(String params) {
    return _weatherRepository.fetchSuggestData(params);
  }
}

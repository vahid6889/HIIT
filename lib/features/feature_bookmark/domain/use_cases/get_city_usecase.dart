import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/core/usecase/use_case.dart';
import 'package:hiit/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:hiit/features/feature_bookmark/domain/repository/city_repository.dart';

class GetCityUseCase implements UseCase<DataState<City?>, String> {
  final CityRepository _cityRepository;
  GetCityUseCase(this._cityRepository);

  @override
  Future<DataState<City?>> call(String params) {
    return _cityRepository.findCityByName(params);
  }
}

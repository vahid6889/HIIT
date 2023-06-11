import 'package:Hiit/features/feature_bookmark/domain/repository/city_repository.dart';
import 'package:Hiit/core/resources/data_state.dart';
import 'package:Hiit/core/usecase/use_case.dart';

class DeleteCityUseCase implements UseCase<DataState<String>, String> {
  final CityRepository _cityRepository;
  DeleteCityUseCase(this._cityRepository);

  @override
  Future<DataState<String>> call(String params) {
    return _cityRepository.deleteCityByName(params);
  }
}

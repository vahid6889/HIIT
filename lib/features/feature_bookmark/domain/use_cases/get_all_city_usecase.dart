import 'package:hiit/core/resources/data_state.dart';
import 'package:hiit/core/usecase/use_case.dart';
import 'package:hiit/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:hiit/features/feature_bookmark/domain/repository/city_repository.dart';

class GetAllCityUseCase implements UseCase<DataState<List<City>>, NoParams> {
  final CityRepository _cityRepository;
  GetAllCityUseCase(this._cityRepository);

  @override
  Future<DataState<List<City>>> call(NoParams params) {
    return _cityRepository.getAllCityFromDB();
  }
}

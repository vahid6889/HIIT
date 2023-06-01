import 'package:hiit/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetAllCityStatus extends Equatable {}

// loading state
class GetAllCityLoading extends GetAllCityStatus {
  @override
  List<Object?> get props => [];
}

// loaded state
class GetAllCityCompleted extends GetAllCityStatus {
  final List<City> cities;
  GetAllCityCompleted(this.cities);

  @override
  List<Object?> get props => [cities];
}

// error state
class GetAllCityError extends GetAllCityStatus {
  final String? message;
  GetAllCityError(this.message);

  @override
  List<Object?> get props => [message];
}

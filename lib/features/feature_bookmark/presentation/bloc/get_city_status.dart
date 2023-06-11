import 'package:Hiit/features/feature_bookmark/domain/entities/city_entity.dart';
import 'package:equatable/equatable.dart';

abstract class GetCityStatus extends Equatable {}

// loading state
class GetCityLoading extends GetCityStatus {
  @override
  List<Object?> get props => [];
}

// loaded state
class GetCityCompleted extends GetCityStatus {
  final City? city;
  GetCityCompleted(this.city);

  @override
  List<Object?> get props => [city];
}

// error state
class GetCityError extends GetCityStatus {
  final String? message;
  GetCityError(this.message);

  @override
  List<Object?> get props => [message];
}

import 'package:equatable/equatable.dart';
import 'package:Hiit/features/feature_weather/data/models/current_air_quality_city_model.dart';

class CurrentAirQualityCityEntity extends Equatable {
  final Coord? coord;
  final List<ListAir>? list;

  const CurrentAirQualityCityEntity({
    this.coord,
    this.list,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        coord,
        list,
      ];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}

import 'package:Hiit/features/feature_weather/domain/entities/current_air_quality_city_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class AqStatus extends Equatable {}

class AqLoading extends AqStatus {
  @override
  List<Object?> get props => [];
}

class AqCompleted extends AqStatus {
  final CurrentAirQualityCityEntity currentAirQualityCityEntity;

  AqCompleted(this.currentAirQualityCityEntity);

  @override
  List<Object?> get props => [currentAirQualityCityEntity];
}

class AqError extends AqStatus {
  final String message;

  AqError(this.message);

  @override
  List<Object?> get props => [message];
}

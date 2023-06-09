import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:Hiit/features/feature_weather/domain/entities/forecast_hourly_entity.dart';

@immutable
abstract class FhStatus extends Equatable {}

class FhLoading extends FhStatus {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class FhCompleted extends FhStatus {
  final ForecastHourlyEntity forecastHourlyEntity;

  FhCompleted(this.forecastHourlyEntity);

  @override
  // TODO: implement props
  List<Object?> get props => [FhCompleted];
}

class FhError extends FhStatus {
  final String message;

  FhError(this.message);

  @override
  // TODO: implement props
  List<Object?> get props => [message];
}

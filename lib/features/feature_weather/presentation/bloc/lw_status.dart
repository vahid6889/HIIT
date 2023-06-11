import 'package:Hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class LwStatus extends Equatable {}

class LwInitial extends LwStatus {
  @override
  List<Object?> get props => [];
}

class LwLoading extends LwStatus {
  @override
  List<Object?> get props => [];
}

class LwCompleted extends LwStatus {
  final CurrentCityEntity currentCityEntity;

  LwCompleted(this.currentCityEntity);

  @override
  List<Object?> get props => [currentCityEntity];
}

class LwError extends LwStatus {
  final String message;

  LwError(this.message);

  @override
  List<Object?> get props => [message];
}

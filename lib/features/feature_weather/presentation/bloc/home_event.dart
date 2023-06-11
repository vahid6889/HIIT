part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class LoadCwEvent extends HomeEvent {
  final String cityName;

  LoadCwEvent(this.cityName);
}

class LoadLwEvent extends HomeEvent {
  final ForecastParams forecastParams;

  LoadLwEvent(this.forecastParams);
}

class LoadFwEvent extends HomeEvent {
  final ForecastParams forecastParams;

  LoadFwEvent(this.forecastParams);
}

class LoadFhEvent extends HomeEvent {
  final ForecastParams forecastParams;

  LoadFhEvent(this.forecastParams);
}

class LoadAqEvent extends HomeEvent {
  final ForecastParams forecastParams;

  LoadAqEvent(this.forecastParams);
}

import 'package:equatable/equatable.dart';
import 'package:Hiit/features/feature_weather/data/models/forecast_hourly_model.dart';

class ForecastHourlyEntity extends Equatable {
  final double? lat;
  final double? lon;
  final String? timezone;
  final int? timezoneOffset;
  final List<Alerts>? alerts;
  final List<Hourly>? hourly;

  const ForecastHourlyEntity({
    this.lat,
    this.lon,
    this.timezone,
    this.timezoneOffset,
    this.alerts,
    this.hourly,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [
        lat,
        lon,
        timezone,
        timezoneOffset,
        alerts,
        hourly,
      ];

  @override
  // TODO: implement stringify
  bool? get stringify => true;
}

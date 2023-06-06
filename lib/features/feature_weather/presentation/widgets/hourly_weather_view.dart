import 'package:flutter/material.dart';
import 'package:hiit/core/presentation/widgets/app_background.dart';
import 'package:hiit/core/utils/date_converter.dart';
import 'package:hiit/features/feature_weather/data/models/forecast_hourly_model.dart';

class HourlyWeatherView extends StatefulWidget {
  final Hourly hourly;
  final int timeZone;
  const HourlyWeatherView({
    super.key,
    required this.hourly,
    required this.timeZone,
  });

  @override
  State<HourlyWeatherView> createState() => _HourlyWeatherViewState();
}

class _HourlyWeatherViewState extends State<HourlyWeatherView> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 15,
      child: Padding(
        padding: const EdgeInsets.only(right: 5),
        child: Card(
          color: Colors.transparent,
          elevation: 0,
          child: Column(
            children: [
              Text(
                DateConverter.changeDtToDateTimeHour(
                    widget.hourly.dt, widget.timeZone),
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 1.0),
                child: AppBackground.setIconForMain(
                  widget.hourly.weather![0].description,
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: Text(
                    "${widget.hourly.temp!.round()}\u00B0",
                    style: const TextStyle(
                      fontSize: 17,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

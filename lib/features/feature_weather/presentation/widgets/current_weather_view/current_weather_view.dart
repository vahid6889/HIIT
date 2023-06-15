import 'package:Hiit/features/feature_weather/presentation/widgets/current_weather_view/current_weather_desktop.dart';
import 'package:Hiit/features/feature_weather/presentation/widgets/current_weather_view/current_weather_mobile.dart';
import 'package:flutter/material.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_city_entity.dart';

class CurrentWeatherView extends StatelessWidget {
  final CurrentCityEntity currentCityEntity;
  const CurrentWeatherView({
    super.key,
    required this.currentCityEntity,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 360) {
        return CurrentWeatherDesktop(currentCityEntity: currentCityEntity);
      } else {
        return CurrentWeatherMobile(currentCityEntity: currentCityEntity);
      }
    });
  }
}

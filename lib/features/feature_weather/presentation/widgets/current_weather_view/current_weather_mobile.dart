import 'package:Hiit/core/presentation/widgets/app_background.dart';
import 'package:Hiit/core/utils/constants.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:flutter/material.dart';

class CurrentWeatherMobile extends StatelessWidget {
  final CurrentCityEntity currentCityEntity;
  const CurrentWeatherMobile({
    super.key,
    required this.currentCityEntity,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          currentCityEntity.name!,
          style: kCurrentWeatherNameMobileStyle,
        ),
        const SizedBox(height: 10),
        Text(
          currentCityEntity.weather!.first.description!,
          style: kCurrentWeatherDescriptionMobileStyle,
        ),
        const SizedBox(height: 10),
        AppBackground.setIconForMain(
          description: currentCityEntity.weather!.first.description!,
          width: 50.0,
          height: 50.0,
        ),
        const SizedBox(height: 10),
        Text(
          "${currentCityEntity.main!.temp!.round()}\u00B0",
          style: kCurrentWeatherTempMobileStyle,
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// max temp
            Column(
              children: [
                const Text(
                  "max",
                  style: kCurrentWeatherTempMaxMobileStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  "${currentCityEntity.main!.tempMax!.round()}\u00B0",
                  style: kCurrentWeatherTempMaxMobileStyle,
                ),
              ],
            ),

            /// divider
            Padding(
              padding: const EdgeInsets.only(
                left: 10.0,
                right: 10.0,
              ),
              child: Container(
                color: Colors.grey,
                width: 2,
                height: 35,
              ),
            ),

            /// min temp
            Column(
              children: [
                const Text(
                  "min",
                  style: kCurrentWeatherTempMinMobileStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  "${currentCityEntity.main!.tempMin!.round()}\u00B0",
                  style: kCurrentWeatherTempMinMobileStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

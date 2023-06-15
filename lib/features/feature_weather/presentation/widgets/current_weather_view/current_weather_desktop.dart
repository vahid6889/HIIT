import 'package:Hiit/core/presentation/widgets/app_background.dart';
import 'package:Hiit/core/utils/constants.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:flutter/material.dart';

class CurrentWeatherDesktop extends StatelessWidget {
  const CurrentWeatherDesktop({
    super.key,
    required this.currentCityEntity,
  });

  final CurrentCityEntity currentCityEntity;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(height: 10),
        Text(
          currentCityEntity.name!,
          style: kCurrentWeatherNameDesktopStyle,
        ),
        const SizedBox(height: 20),
        Text(
          currentCityEntity.weather!.first.description!,
          style: kCurrentWeatherDescriptionDesktopStyle,
        ),
        const SizedBox(height: 20),
        AppBackground.setIconForMain(
          description: currentCityEntity.weather!.first.description!,
          width: null,
          height: null,
        ),
        const SizedBox(height: 20),
        Text(
          "${currentCityEntity.main!.temp!.round()}\u00B0",
          style: kCurrentWeatherTempDesktopStyle,
        ),
        const SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /// max temp
            Column(
              children: [
                const Text(
                  "max",
                  style: kCurrentWeatherTempMaxDesktopStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  "${currentCityEntity.main!.tempMax!.round()}\u00B0",
                  style: kCurrentWeatherTempMaxDesktopStyle,
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
                height: 40,
              ),
            ),

            /// min temp
            Column(
              children: [
                const Text(
                  "min",
                  style: kCurrentWeatherTempMinDesktopStyle,
                ),
                const SizedBox(height: 10),
                Text(
                  "${currentCityEntity.main!.tempMin!.round()}\u00B0",
                  style: kCurrentWeatherTempMinDesktopStyle,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

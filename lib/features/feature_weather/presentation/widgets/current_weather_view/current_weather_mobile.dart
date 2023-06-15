import 'package:Hiit/core/presentation/widgets/app_background.dart';
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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 15,
          ),
        ),
        const SizedBox(height: 10),
        Text(
          currentCityEntity.weather!.first.description!,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 10,
          ),
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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
          ),
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
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${currentCityEntity.main!.tempMax!.round()}\u00B0",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
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
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${currentCityEntity.main!.tempMin!.round()}\u00B0",
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

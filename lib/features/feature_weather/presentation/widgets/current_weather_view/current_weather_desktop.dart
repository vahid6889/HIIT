import 'package:Hiit/core/presentation/widgets/app_background.dart';
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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          currentCityEntity.weather!.first.description!,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
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
          style: const TextStyle(
            color: Colors.white,
            fontSize: 50,
          ),
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
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${currentCityEntity.main!.tempMax!.round()}\u00B0",
                  style: const TextStyle(
                    fontSize: 16,
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
                height: 40,
              ),
            ),

            /// min temp
            Column(
              children: [
                const Text(
                  "min",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "${currentCityEntity.main!.tempMin!.round()}\u00B0",
                  style: const TextStyle(
                    fontSize: 16,
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

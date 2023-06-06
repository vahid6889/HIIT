import 'package:flutter/material.dart';
import 'package:hiit/core/presentation/widgets/app_background.dart';
import 'package:hiit/features/feature_weather/domain/entities/current_city_entity.dart';

class CurrentWeatherView extends StatelessWidget {
  final CurrentCityEntity currentCityEntity;
  const CurrentWeatherView({
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
            fontSize: 30,
          ),
        ),
        const SizedBox(height: 20),
        Text(
          currentCityEntity.weather![0].description!,
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 20,
          ),
        ),
        const SizedBox(height: 20),
        AppBackground.setIconForMain(
          currentCityEntity.weather![0].description!,
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

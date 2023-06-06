import 'package:flutter/material.dart';
import 'package:hiit/features/feature_weather/domain/entities/current_city_entity.dart';

class PropertlyWeatherView extends StatelessWidget {
  final CurrentCityEntity currentCityEntity;
  final String sunrise;
  final String sunset;
  const PropertlyWeatherView({
    super.key,
    required this.currentCityEntity,
    required this.sunrise,
    required this.sunset,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Column(
          children: [
            Text(
              "wind speed",
              style: TextStyle(
                fontSize: height * 0.017,
                color: Colors.amber,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0),
              child: Text(
                "${currentCityEntity.wind!.speed!} m/s",
                style: TextStyle(
                  fontSize: height * 0.016,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            color: Colors.white24,
            height: 30,
            width: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              Text(
                "sunrise",
                style: TextStyle(
                  fontSize: height * 0.017,
                  color: Colors.amber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  sunrise,
                  style: TextStyle(
                    fontSize: height * 0.016,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            color: Colors.white24,
            height: 30,
            width: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              Text(
                "sunset",
                style: TextStyle(
                  fontSize: height * 0.017,
                  color: Colors.amber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  sunset,
                  style: TextStyle(
                    fontSize: height * 0.016,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Container(
            color: Colors.white24,
            height: 30,
            width: 2,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Column(
            children: [
              Text(
                "humidity",
                style: TextStyle(
                  fontSize: height * 0.017,
                  color: Colors.amber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "${currentCityEntity.main!.humidity!}%",
                  style: TextStyle(
                    fontSize: height * 0.016,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

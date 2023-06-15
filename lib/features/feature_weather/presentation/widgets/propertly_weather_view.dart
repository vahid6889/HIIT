import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Hiit/core/presentation/widgets/app_background.dart';
import 'package:Hiit/core/presentation/widgets/dot_loading_widget.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_air_quality_city_entity.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_city_entity.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/aq_status.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/home_bloc.dart';

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
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: (width < 360 || width > 360 && width < 600 || height > 600)
          ? const EdgeInsets.only(left: 0.0, right: 0.0)
          : const EdgeInsets.only(left: 100.0, right: 100.0),
      child: Row(
        mainAxisAlignment:
            (width < 360 || width > 360 && width < 600 || height > 600)
                ? MainAxisAlignment.center
                : MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              Text(
                "wind speed",
                style: TextStyle(
                  fontSize: (height > 600) ? height * 0.017 : height * 0.025,
                  color: Colors.amber,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Text(
                  "${currentCityEntity.wind!.speed} m/s",
                  style: TextStyle(
                    fontSize: (height > 600) ? height * 0.016 : height * 0.023,
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
                    fontSize: (height > 600) ? height * 0.017 : height * 0.025,
                    color: Colors.amber,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    sunrise,
                    style: TextStyle(
                      fontSize:
                          (height > 600) ? height * 0.016 : height * 0.023,
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
                    fontSize: (height > 600) ? height * 0.017 : height * 0.025,
                    color: Colors.amber,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    sunset,
                    style: TextStyle(
                      fontSize:
                          (height > 600) ? height * 0.016 : height * 0.023,
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
                    fontSize: (height > 600) ? height * 0.017 : height * 0.025,
                    color: Colors.amber,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: Text(
                    "${currentCityEntity.main!.humidity}%",
                    style: TextStyle(
                      fontSize:
                          (height > 600) ? height * 0.016 : height * 0.023,
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
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              /// show Loading State for Aq
              if (state.aqStatus is AqLoading) {
                return const DotLoadingWidget();
              }

              /// show Completed State for Aq
              if (state.aqStatus is AqCompleted) {
                /// cast
                final AqCompleted aqCompleted = state.aqStatus as AqCompleted;
                final CurrentAirQualityCityEntity currentAirQualityCityEntity =
                    aqCompleted.currentAirQualityCityEntity;
                final String airQuality = AppBackground.setAirQualityForMain(
                  currentAirQualityCityEntity.list!.first.main!.aqi,
                );
                return Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Column(
                    children: [
                      Text(
                        "air quality",
                        style: TextStyle(
                          fontSize:
                              (height > 600) ? height * 0.017 : height * 0.025,
                          color: Colors.amber,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10.0),
                        child: Text(
                          airQuality,
                          style: TextStyle(
                            fontSize: (height > 600)
                                ? height * 0.016
                                : height * 0.023,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              /// show Error State for Aq
              if (state.aqStatus is AqError) {
                final AqError aqError = state.aqStatus as AqError;
                return Center(
                  child: Text(aqError.message),
                );
              }
              return Container();
            },
          ),
        ],
      ),
    );
  }
}

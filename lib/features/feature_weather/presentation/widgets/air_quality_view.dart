import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Hiit/core/presentation/widgets/app_background.dart';
import 'package:Hiit/core/presentation/widgets/dot_loading_widget.dart';
import 'package:Hiit/features/feature_weather/domain/entities/current_air_quality_city_entity.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/aq_status.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/home_bloc.dart';

class AirQualityView extends StatelessWidget {
  const AirQualityView({super.key});

  List<dynamic> componentsAirQualityList(
      CurrentAirQualityCityEntity currentAirQualityCityEntity) {
    return [
      [
        "co",
        "${currentAirQualityCityEntity.list!.first.components!.co.round()} μg/m3",
      ],
      [
        "no",
        "${currentAirQualityCityEntity.list!.first.components!.no.round()} μg/m3",
      ],
      [
        "no2",
        "${currentAirQualityCityEntity.list!.first.components!.no2.round()} μg/m3",
      ],
      [
        "o3",
        "${currentAirQualityCityEntity.list!.first.components!.o3.round()} μg/m3",
      ],
      [
        "so2",
        "${currentAirQualityCityEntity.list!.first.components!.so2.round()} μg/m3",
      ],
      [
        "pm2_5",
        "${currentAirQualityCityEntity.list!.first.components!.pm25.round()} μg/m3",
      ],
      [
        "pm10",
        "${currentAirQualityCityEntity.list!.first.components!.pm10.round()} μg/m3",
      ],
      [
        "nh3",
        "${currentAirQualityCityEntity.list!.first.components!.nh3.round()} μg/m3",
      ],
    ];
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return BlocBuilder<HomeBloc, HomeState>(
      builder: (BuildContext context, state) {
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

          return Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              shrinkWrap: true,
              childAspectRatio: (1 / .3),
              physics: const BouncingScrollPhysics(),
              children: List.generate(
                componentsAirQualityList(currentAirQualityCityEntity).length,
                (index) {
                  return Card(
                    // color: Colors.transparent,
                    color: Colors.blueGrey,
                    elevation: 0,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              AppBackground.setAirQualityForComponents(
                                componentsAirQualityList(
                                    currentAirQualityCityEntity)[index][0],
                              ),
                              style: TextStyle(
                                fontSize: height * 0.017,
                                color: Colors.amber,
                              ),
                            ),
                            Text(
                              componentsAirQualityList(
                                  currentAirQualityCityEntity)[index][1],
                              style: TextStyle(
                                fontSize: height * 0.016,
                                color: Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
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

        /// show Default State for Fw
        return Container();
      },
    );
  }
}

import 'package:Hiit/features/feature_weather/presentation/widgets/hourly_weather_view/hourly_grid_view_desktop.dart';
import 'package:Hiit/features/feature_weather/presentation/widgets/hourly_weather_view/hourly_grid_view_mobile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Hiit/core/params/forecast_params.dart';
import 'package:Hiit/core/presentation/widgets/dot_loading_widget.dart';
import 'package:Hiit/features/feature_weather/data/models/forecast_hourly_model.dart';
import 'package:Hiit/features/feature_weather/domain/entities/forecast_hourly_entity.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/fh_status.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/home_bloc.dart';

class HourlyWeatherView extends StatefulWidget {
  final ForecastParams forecastParams;
  const HourlyWeatherView({
    super.key,
    required this.forecastParams,
  });

  @override
  State<HourlyWeatherView> createState() => _HourlyWeatherViewState();
}

class _HourlyWeatherViewState extends State<HourlyWeatherView> {
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          // child: Center(
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, state) {
              /// show Loading State for Fw
              if (state.fhStatus is FhLoading) {
                return const DotLoadingWidget();
              }

              /// show Completed State for Fw
              if (state.fhStatus is FhCompleted) {
                /// casting
                final FhCompleted fhCompleted = state.fhStatus as FhCompleted;
                final ForecastHourlyEntity forecastHourlyEntity =
                    fhCompleted.forecastHourlyEntity;
                final List<Hourly> mainHourly = forecastHourlyEntity.hourly!;
                final int mainTimeZone = forecastHourlyEntity.timezoneOffset!;
                return LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 360) {
                      return HourlyGridViewDesktop(
                        mainHourly: mainHourly,
                        mainTimeZone: mainTimeZone,
                      );
                    } else {
                      return HourlyGridViewMobile(
                        mainHourly: mainHourly,
                        mainTimeZone: mainTimeZone,
                      );
                    }
                  },
                );
              }

              /// show Error State for Fw
              if (state.fhStatus is FhError) {
                final FhError fhError = state.fhStatus as FhError;
                return Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: height * 0.2,
                      ),
                      Text(
                        fhError.message,
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                      TextButton(
                        style: TextButton.styleFrom(
                          side: const BorderSide(
                            color: Colors.white,
                          ),
                        ),
                        onPressed: () {
                          BlocProvider.of<HomeBloc>(context).add(
                            LoadFhEvent(widget.forecastParams),
                          );
                        },
                        child: const Text(
                          'Try again',
                          style: TextStyle(
                            color: Colors.amber,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }

              /// show Default State for Fw
              return Container();
            },
          ),
          // ),
        ),
      ),
    );
  }
}

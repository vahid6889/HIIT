import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:Hiit/core/presentation/widgets/app_background.dart';
import 'package:Hiit/core/presentation/widgets/dot_loading_widget.dart';
import 'package:Hiit/core/utils/date_converter.dart';
import 'package:Hiit/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:flutter/material.dart';
import 'package:Hiit/features/feature_weather/domain/entities/forecast_days_entity.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/fw_status.dart';
import 'package:Hiit/features/feature_weather/presentation/bloc/home_bloc.dart';

class DaysWeatherView extends StatefulWidget {
  const DaysWeatherView({super.key});

  @override
  State<DaysWeatherView> createState() => _DaysWeatherViewState();
}

class _DaysWeatherViewState extends State<DaysWeatherView>
    with SingleTickerProviderStateMixin {
  late AnimationController animationController;
  late Animation animation;

  @override
  void initState() {
    super.initState();

    animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    animation = Tween(
      begin: -1.0,
      end: 0.0,
    ).animate(
      CurvedAnimation(
        parent: animationController,
        curve: const Interval(0.5, 1, curve: Curves.decelerate),
      ),
    );
    animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Padding(
      padding: const EdgeInsets.only(top: 15),
      child: SizedBox(
        width: double.infinity,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Center(
            child: BlocBuilder<HomeBloc, HomeState>(
              builder: (BuildContext context, state) {
                /// show Loading State for Fw
                if (state.fwStatus is FwLoading) {
                  return const DotLoadingWidget();
                }

                /// show Completed State for Fw
                if (state.fwStatus is FwCompleted) {
                  /// casting
                  final FwCompleted fwCompleted = state.fwStatus as FwCompleted;
                  final ForecastDaysEntity forecastDaysEntity =
                      fwCompleted.forecastDaysEntity;
                  final List<Daily> mainDaily = forecastDaysEntity.daily!;

                  return ListView.builder(
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    itemCount: 8,
                    itemBuilder: (
                      BuildContext context,
                      int index,
                    ) {
                      return AnimatedBuilder(
                        animation: animationController,
                        builder: (context, child) {
                          return Transform(
                            transform: Matrix4.translationValues(
                                animation.value * width, 0.0, 0.0),
                            child: Padding(
                              padding: const EdgeInsets.only(right: 5),
                              child: Card(
                                color: Colors.transparent,
                                elevation: 0,
                                child: SizedBox(
                                  width: 50,
                                  height: 50,
                                  child: Column(
                                    children: [
                                      Text(
                                        DateConverter.changeDtToDateTime(
                                            mainDaily[index].dt),
                                        style: const TextStyle(
                                            fontSize: 12, color: Colors.grey),
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 5.0),
                                        child: AppBackground.setIconForMain(
                                          mainDaily[index]
                                              .weather![0]
                                              .description,
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(top: 5.0),
                                          child: Text(
                                            "${mainDaily[index].temp!.day!.round()}\u00B0",
                                            style: const TextStyle(
                                              fontSize: 15,
                                              color: Colors.white,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                }

                /// show Error State for Fw
                if (state.fwStatus is FwError) {
                  final FwError fwError = state.fwStatus as FwError;
                  return Center(
                    child: Text(fwError.message),
                  );
                }

                /// show Default State for Fw
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationController.dispose();
    // _fwBloc.dispose();
    // _cwBloc.dispose();
    super.dispose();
  }
}

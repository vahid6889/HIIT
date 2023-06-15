import 'package:Hiit/core/presentation/widgets/app_background.dart';
import 'package:Hiit/core/utils/date_converter.dart';
import 'package:Hiit/features/feature_weather/data/models/forecast_hourly_model.dart';
import 'package:flutter/material.dart';

class HourlyGridViewMobile extends StatelessWidget {
  const HourlyGridViewMobile({
    super.key,
    required this.mainHourly,
    required this.mainTimeZone,
  });
  final List<Hourly> mainHourly;
  final int mainTimeZone;

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      children: List.generate(
        (mainHourly.isEmpty) ? 0 : mainHourly.length,
        (index) {
          return Container(
            height: 15,
            child: Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Card(
                color: Colors.transparent,
                elevation: 0,
                child: Column(
                  children: [
                    Text(
                      DateConverter.changeDtToDateTimeHour(
                          mainHourly[index].dt, mainTimeZone),
                      style: const TextStyle(
                        fontSize: 12,
                        color: Colors.grey,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: AppBackground.setIconForMain(
                        description:
                            mainHourly[index].weather!.first.description,
                        width: 50,
                        height: 50,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "${mainHourly[index].temp.round()}\u00B0",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

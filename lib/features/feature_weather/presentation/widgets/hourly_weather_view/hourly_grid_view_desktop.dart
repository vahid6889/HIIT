import 'package:Hiit/core/presentation/widgets/app_background.dart';
import 'package:Hiit/core/utils/constants.dart';
import 'package:Hiit/core/utils/date_converter.dart';
import 'package:Hiit/features/feature_weather/data/models/forecast_hourly_model.dart';
import 'package:flutter/material.dart';

class HourlyGridViewDesktop extends StatelessWidget {
  const HourlyGridViewDesktop({
    super.key,
    required this.mainHourly,
    required this.mainTimeZone,
  });
  final List<Hourly> mainHourly;
  final int mainTimeZone;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const BouncingScrollPhysics(),
      mainAxisSpacing: (width > 600) ? 0 : 20,
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
                      style: kHourlyTimeDesktopStyle,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 1.0),
                      child: AppBackground.setIconForMain(
                        description:
                            mainHourly[index].weather!.first.description,
                        width: null,
                        height: null,
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5.0),
                        child: Text(
                          "${mainHourly[index].temp.round()}\u00B0",
                          style: kHourlyTempDesktopStyle,
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

import 'package:Hiit/core/presentation/widgets/app_background.dart';
import 'package:Hiit/core/utils/constants.dart';
import 'package:Hiit/core/utils/date_converter.dart';
import 'package:Hiit/features/feature_weather/data/models/forecast_days_model.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class DaysTransformDesktop extends StatelessWidget {
  DaysTransformDesktop({
    super.key,
    required this.animation,
    required this.index,
    required this.mainDaily,
  });

  final List<Daily> mainDaily;
  late Animation animation;
  final int index;

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;

    return Transform(
      transform: Matrix4.translationValues(
        animation.value * width,
        0.0,
        0.0,
      ),
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
                  DateConverter.changeDtToDateTime(mainDaily[index].dt),
                  style: kDaysTimeDesktopStyle,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 5.0),
                  child: AppBackground.setIconForMain(
                    description: mainDaily[index].weather!.first.description,
                    width: null,
                    height: null,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5.0),
                    child: Text(
                      "${mainDaily[index].temp!.day!.round()}\u00B0",
                      style: kDaysTempDesktopStyle,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

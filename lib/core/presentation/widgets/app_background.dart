import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AppBackground {
  static AssetImage getBackGroundImage() {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk').format(now);
    if (6 > int.parse(formattedDate)) {
      return const AssetImage('assets/images/night-pic.jpg');
    } else if (18 > int.parse(formattedDate)) {
      return const AssetImage('assets/images/pic-bg.jpg');
    } else {
      return const AssetImage('assets/images/night-pic.jpg');
    }
  }

  static Image setIconForMain(description) {
    switch (description) {
      case "clear sky":
        return Image(
          image: const AssetImage('assets/images/icons8-sun-96.png'),
        );
      case "few clouds":
        return Image(
          image:
              const AssetImage('assets/images/icons8-partly-cloudy-day-80.png'),
        );
      case "clouds":
        return Image(
          image: const AssetImage('assets/images/icons8-clouds-80.png'),
        );
      case "thunderstorm":
        return Image(
          image: const AssetImage('assets/images/icons8-storm-80.png'),
        );
      case "drizzle":
        return Image(
          image: const AssetImage('assets/images/icons8-rain-cloud-80.png'),
        );
      case "rain":
        return Image(
          image: const AssetImage('assets/images/icons8-heavy-rain-80.png'),
        );
      case "snow":
        return Image(
          image: const AssetImage('assets/images/icons8-snow-80.png'),
        );
      default:
        return Image(
          image: const AssetImage('assets/images/icons8-windy-weather-80.png'),
        );
    }

    // if (description == "clear sky") {
    //   return const Image(
    //       image: AssetImage(
    //     'assets/images/icons8-sun-96.png',
    //   ));
    // } else if (description == "few clouds") {
    //   return const Image(
    //       image: AssetImage('assets/images/icons8-partly-cloudy-day-80.png'));
    // } else if (description.contains("clouds")) {
    //   return const Image(
    //       image: AssetImage('assets/images/icons8-clouds-80.png'));
    // } else if (description.contains("thunderstorm")) {
    //   return const Image(
    //       image: AssetImage('assets/images/icons8-storm-80.png'));
    // } else if (description.contains("drizzle")) {
    //   return const Image(
    //       image: AssetImage('assets/images/icons8-rain-cloud-80.png'));
    // } else if (description.contains("rain")) {
    //   return const Image(
    //       image: AssetImage('assets/images/icons8-heavy-rain-80.png'));
    // } else if (description.contains("snow")) {
    //   return const Image(image: AssetImage('assets/images/icons8-snow-80.png'));
    // } else {
    //   return const Image(
    //       image: AssetImage('assets/images/icons8-windy-weather-80.png'));
    // }
  }
}

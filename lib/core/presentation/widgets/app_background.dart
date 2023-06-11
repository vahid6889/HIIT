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
  }

  static String setAirQualityForMain(index) {
    switch (index) {
      case 1:
        return "Good";
      case 2:
        return "Fair";
      case 3:
        return "Moderate";
      case 4:
        return "Poor";
      case 5:
        return "Very Poor";
      default:
        return "No index";
    }
  }

  static String setAirQualityForComponents(componentName) {
    switch (componentName) {
      case "co":
        return "Carbon monoxide";
      case "no":
        return "Nitrogen monoxide";
      case "no2":
        return "Nitrogen dioxide";
      case "o3":
        return "Ozone";
      case "so2":
        return "Sulphur dioxide";
      case "pm2_5":
        return "Fine particles matter";
      case "pm10":
        return "Coarse particulate matter";
      case "nh3":
        return "Ammonia";
      default:
        return "No component";
    }
  }
}

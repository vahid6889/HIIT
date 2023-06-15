import 'package:flutter/material.dart';

class Constants {
  static const baseUrl = 'https://api.openweathermap.org';
  static const apiKeys1 = '879e6d95e1194fb79e82294e5465f7aa';
}

kPropertyWeatherTitleStyle(double height) {
  return TextStyle(
    fontSize: (height > 600) ? height * 0.017 : height * 0.025,
    color: Colors.amber,
  );
}

kPropertyWeatherValueStyle(double height) {
  return TextStyle(
    fontSize: (height > 600) ? height * 0.016 : height * 0.023,
    color: Colors.white,
  );
}

const kHourlyTimeDesktopStyle = TextStyle(
  fontSize: 15,
  color: Colors.grey,
);

const kHourlyTempDesktopStyle = TextStyle(
  fontSize: 17,
  color: Colors.grey,
);

const kHourlyTimeMobileStyle = TextStyle(
  fontSize: 12,
  color: Colors.grey,
);

const kHourlyTempMobileStyle = TextStyle(
  fontSize: 14,
  color: Colors.white,
);

const kDaysTimeDesktopStyle = TextStyle(
  fontSize: 12,
  color: Colors.grey,
);

const kDaysTempDesktopStyle = TextStyle(
  fontSize: 15,
  color: Colors.white,
);

const kDaysTimeMobileStyle = TextStyle(
  fontSize: 9,
  color: Colors.grey,
);

const kDaysTempMobileStyle = TextStyle(
  fontSize: 10,
  color: Colors.white,
);

const kCurrentWeatherNameDesktopStyle = TextStyle(
  color: Colors.white,
  fontSize: 30,
);

const kCurrentWeatherDescriptionDesktopStyle = TextStyle(
  color: Colors.grey,
  fontSize: 20,
);

const kCurrentWeatherTempDesktopStyle = TextStyle(
  color: Colors.white,
  fontSize: 50,
);

const kCurrentWeatherTempMaxDesktopStyle = TextStyle(
  fontSize: 16,
  color: Colors.grey,
);

const kCurrentWeatherTempMinDesktopStyle = TextStyle(
  fontSize: 16,
  color: Colors.grey,
);

const kCurrentWeatherNameMobileStyle = TextStyle(
  color: Colors.white,
  fontSize: 15,
);

const kCurrentWeatherDescriptionMobileStyle = TextStyle(
  color: Colors.grey,
  fontSize: 10,
);

const kCurrentWeatherTempMobileStyle = TextStyle(
  color: Colors.white,
  fontSize: 25,
);

const kCurrentWeatherTempMaxMobileStyle = TextStyle(
  fontSize: 12,
  color: Colors.grey,
);

const kCurrentWeatherTempMinMobileStyle = TextStyle(
  fontSize: 12,
  color: Colors.grey,
);

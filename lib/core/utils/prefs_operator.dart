import 'package:Hiit/locator.dart';
import 'package:shared_preferences/shared_preferences.dart';

class PrefsOperator {
  late SharedPreferences sharedPreferences;
  PrefsOperator() {
    sharedPreferences = locator<SharedPreferences>();
  }

  saveCitySelected(cityName) async {
    sharedPreferences.setString("city_name", cityName);
  }

  getCitySelected() async {
    final String? cityName = sharedPreferences.getString('city_name');
    return cityName;
  }

  saveAirQualityMain(qualityName) async {
    sharedPreferences.setString("quality_name", qualityName);
  }

  Future<void> destroy() async {
    sharedPreferences.clear();
  }
}

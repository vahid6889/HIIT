class ForecastHourlyModel2 {
  ForecastHourlyModel2({
      num? lat, 
      num? lon, 
      String? timezone, 
      num? timezoneOffset, 
      List<Hourly>? hourly,}){
    _lat = lat;
    _lon = lon;
    _timezone = timezone;
    _timezoneOffset = timezoneOffset;
    _hourly = hourly;
}

  ForecastHourlyModel2.fromJson(dynamic json) {
    _lat = json['lat'];
    _lon = json['lon'];
    _timezone = json['timezone'];
    _timezoneOffset = json['timezone_offset'];
    if (json['hourly'] != null) {
      _hourly = [];
      json['hourly'].forEach((v) {
        _hourly?.add(Hourly.fromJson(v));
      });
    }
  }
  num? _lat;
  num? _lon;
  String? _timezone;
  num? _timezoneOffset;
  List<Hourly>? _hourly;

  num? get lat => _lat;
  num? get lon => _lon;
  String? get timezone => _timezone;
  num? get timezoneOffset => _timezoneOffset;
  List<Hourly>? get hourly => _hourly;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lat'] = _lat;
    map['lon'] = _lon;
    map['timezone'] = _timezone;
    map['timezone_offset'] = _timezoneOffset;
    if (_hourly != null) {
      map['hourly'] = _hourly?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Hourly {
  Hourly({
      num? dt, 
      num? temp, 
      num? feelsLike, 
      num? pressure, 
      num? humidity, 
      num? dewPoint, 
      num? uvi, 
      num? clouds, 
      num? visibility, 
      num? windSpeed, 
      num? windDeg, 
      num? windGust, 
      List<Weather>? weather, 
      num? pop,}){
    _dt = dt;
    _temp = temp;
    _feelsLike = feelsLike;
    _pressure = pressure;
    _humidity = humidity;
    _dewPoint = dewPoint;
    _uvi = uvi;
    _clouds = clouds;
    _visibility = visibility;
    _windSpeed = windSpeed;
    _windDeg = windDeg;
    _windGust = windGust;
    _weather = weather;
    _pop = pop;
}

  Hourly.fromJson(dynamic json) {
    _dt = json['dt'];
    _temp = json['temp'];
    _feelsLike = json['feels_like'];
    _pressure = json['pressure'];
    _humidity = json['humidity'];
    _dewPoint = json['dew_point'];
    _uvi = json['uvi'];
    _clouds = json['clouds'];
    _visibility = json['visibility'];
    _windSpeed = json['wind_speed'];
    _windDeg = json['wind_deg'];
    _windGust = json['wind_gust'];
    if (json['weather'] != null) {
      _weather = [];
      json['weather'].forEach((v) {
        _weather?.add(Weather.fromJson(v));
      });
    }
    _pop = json['pop'];
  }
  num? _dt;
  num? _temp;
  num? _feelsLike;
  num? _pressure;
  num? _humidity;
  num? _dewPoint;
  num? _uvi;
  num? _clouds;
  num? _visibility;
  num? _windSpeed;
  num? _windDeg;
  num? _windGust;
  List<Weather>? _weather;
  num? _pop;

  num? get dt => _dt;
  num? get temp => _temp;
  num? get feelsLike => _feelsLike;
  num? get pressure => _pressure;
  num? get humidity => _humidity;
  num? get dewPoint => _dewPoint;
  num? get uvi => _uvi;
  num? get clouds => _clouds;
  num? get visibility => _visibility;
  num? get windSpeed => _windSpeed;
  num? get windDeg => _windDeg;
  num? get windGust => _windGust;
  List<Weather>? get weather => _weather;
  num? get pop => _pop;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['dt'] = _dt;
    map['temp'] = _temp;
    map['feels_like'] = _feelsLike;
    map['pressure'] = _pressure;
    map['humidity'] = _humidity;
    map['dew_point'] = _dewPoint;
    map['uvi'] = _uvi;
    map['clouds'] = _clouds;
    map['visibility'] = _visibility;
    map['wind_speed'] = _windSpeed;
    map['wind_deg'] = _windDeg;
    map['wind_gust'] = _windGust;
    if (_weather != null) {
      map['weather'] = _weather?.map((v) => v.toJson()).toList();
    }
    map['pop'] = _pop;
    return map;
  }

}

class Weather {
  Weather({
      num? id, 
      String? main, 
      String? description, 
      String? icon,}){
    _id = id;
    _main = main;
    _description = description;
    _icon = icon;
}

  Weather.fromJson(dynamic json) {
    _id = json['id'];
    _main = json['main'];
    _description = json['description'];
    _icon = json['icon'];
  }
  num? _id;
  String? _main;
  String? _description;
  String? _icon;

  num? get id => _id;
  String? get main => _main;
  String? get description => _description;
  String? get icon => _icon;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['main'] = _main;
    map['description'] = _description;
    map['icon'] = _icon;
    return map;
  }

}
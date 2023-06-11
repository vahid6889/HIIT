import 'package:Hiit/features/feature_weather/domain/entities/forecast_hourly_entity.dart';

class ForecastHourlyModel extends ForecastHourlyEntity {
  const ForecastHourlyModel({
    super.lat,
    super.lon,
    super.timezone,
    super.timezoneOffset,
    super.hourly,
    super.alerts,
  });

  factory ForecastHourlyModel.fromJson(dynamic json) {
    List<Hourly> hourly = [];
    if (json['hourly'] != null) {
      json['hourly'].forEach((v) {
        hourly.add(Hourly.fromJson(v));
      });
    }

    /// convert alerts from json
    List<Alerts> alerts = [];
    if (json['alerts'] != null) {
      json['alerts'].forEach((v) {
        alerts.add(Alerts.fromJson(v));
      });
    }

    return ForecastHourlyModel(
      lat: json['lat'].toDouble(),
      lon: json['lon'].toDouble(),
      timezone: json['timezone'],
      timezoneOffset: json['timezone_offset'],
      hourly: hourly,
      alerts: alerts,
    );
  }
}

class Alerts {
  Alerts({
    String? senderName,
    String? event,
    int? start,
    int? end,
    String? description,
    List<String>? tags,
  }) {
    _senderName = senderName;
    _event = event;
    _start = start;
    _end = end;
    _description = description;
    _tags = tags;
  }

  Alerts.fromJson(dynamic json) {
    _senderName = json['sender_name'];
    _event = json['event'];
    _start = json['start'];
    _end = json['end'];
    _description = json['description'];
    _tags = json['tags'] != null ? json['tags'].cast<String>() : [];
  }
  String? _senderName;
  String? _event;
  int? _start;
  int? _end;
  String? _description;
  List<String>? _tags;

  String? get senderName => _senderName;
  String? get event => _event;
  int? get start => _start;
  int? get end => _end;
  String? get description => _description;
  List<String>? get tags => _tags;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['sender_name'] = _senderName;
    map['event'] = _event;
    map['start'] = _start;
    map['end'] = _end;
    map['description'] = _description;
    map['tags'] = _tags;
    return map;
  }
}

class Temp {
  Temp({
    double? day,
    double? min,
    double? max,
    double? night,
    double? eve,
    double? morn,
  }) {
    _day = day;
    _min = min;
    _max = max;
    _night = night;
    _eve = eve;
    _morn = morn;
  }

  Temp.fromJson(dynamic json) {
    _day = json['day'].toDouble();
    _min = json['min'].toDouble();
    _max = json['max'].toDouble();
    _night = json['night'].toDouble();
    _eve = json['eve'].toDouble();
    _morn = json['morn'].toDouble();
  }
  double? _day;
  double? _min;
  double? _max;
  double? _night;
  double? _eve;
  double? _morn;

  double? get day => _day;
  double? get min => _min;
  double? get max => _max;
  double? get night => _night;
  double? get eve => _eve;
  double? get morn => _morn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['min'] = _min;
    map['max'] = _max;
    map['night'] = _night;
    map['eve'] = _eve;
    map['morn'] = _morn;
    return map;
  }
}

class Feels_like {
  Feels_like({
    double? day,
    double? night,
    double? eve,
    double? morn,
  }) {
    _day = day;
    _night = night;
    _eve = eve;
    _morn = morn;
  }

  Feels_like.fromJson(dynamic json) {
    _day = json['day'].toDouble();
    _night = json['night'].toDouble();
    _eve = json['eve'].toDouble();
    _morn = json['morn'].toDouble();
  }
  double? _day;
  double? _night;
  double? _eve;
  double? _morn;

  double? get day => _day;
  double? get night => _night;
  double? get eve => _eve;
  double? get morn => _morn;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['day'] = _day;
    map['night'] = _night;
    map['eve'] = _eve;
    map['morn'] = _morn;
    return map;
  }
}

/// dt : 1685721600
/// temp : 303.71
/// feels_like : 305.42
/// pressure : 1014
/// humidity : 52
/// dew_point : 292.74
/// uvi : 7.22
/// clouds : 0
/// visibility : 10000
/// wind_speed : 2.95
/// wind_deg : 104
/// wind_gust : 3.8
/// weather : [{"id":800,"main":"Clear","description":"clear sky","icon":"01d"}]
/// pop : 0

class Hourly {
  Hourly({
    int? dt,
    dynamic temp,
    dynamic feelsLike,
    int? pressure,
    int? humidity,
    dynamic dewPoint,
    dynamic uvi,
    int? clouds,
    int? visibility,
    dynamic windSpeed,
    int? windDeg,
    dynamic windGust,
    List<Weather>? weather,
    dynamic pop,
  }) {
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
  int? _dt;
  dynamic _temp;
  dynamic _feelsLike;
  int? _pressure;
  int? _humidity;
  dynamic _dewPoint;
  dynamic _uvi;
  int? _clouds;
  int? _visibility;
  dynamic _windSpeed;
  int? _windDeg;
  dynamic _windGust;
  List<Weather>? _weather;
  dynamic _pop;

  int? get dt => _dt;
  dynamic get temp => _temp;
  dynamic get feelsLike => _feelsLike;
  int? get pressure => _pressure;
  int? get humidity => _humidity;
  dynamic get dewPoint => _dewPoint;
  dynamic get uvi => _uvi;
  int? get clouds => _clouds;
  int? get visibility => _visibility;
  dynamic get windSpeed => _windSpeed;
  int? get windDeg => _windDeg;
  dynamic get windGust => _windGust;
  List<Weather>? get weather => _weather;
  dynamic get pop => _pop;

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
    int? id,
    String? main,
    String? description,
    String? icon,
  }) {
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
  int? _id;
  String? _main;
  String? _description;
  String? _icon;

  int? get id => _id;
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

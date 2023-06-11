import 'package:Hiit/features/feature_weather/domain/entities/current_air_quality_city_entity.dart';

class CurrentAirQualityCityModel extends CurrentAirQualityCityEntity {
  const CurrentAirQualityCityModel({
    super.coord,
    super.list,
  });

  factory CurrentAirQualityCityModel.fromJson(dynamic json) {
    List<ListAir> list = [];
    if (json['list'] != null) {
      json['list'].forEach((v) {
        list.add(ListAir.fromJson(v));
      });
    }

    return CurrentAirQualityCityModel(
      coord: json['coord'] != null ? Coord.fromJson(json['coord']) : null,
      list: list,
    );
  }
}

class ListAir {
  ListAir({
    Main? main,
    Components? components,
    int? dt,
  }) {
    _main = main;
    _components = components;
    _dt = dt;
  }

  ListAir.fromJson(dynamic json) {
    _main = json['main'] != null ? Main.fromJson(json['main']) : null;
    _components = json['components'] != null
        ? Components.fromJson(json['components'])
        : null;
    _dt = json['dt'];
  }
  Main? _main;
  Components? _components;
  int? _dt;

  Main? get main => _main;
  Components? get components => _components;
  int? get dt => _dt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_main != null) {
      map['main'] = _main?.toJson();
    }
    if (_components != null) {
      map['components'] = _components?.toJson();
    }
    map['dt'] = _dt;
    return map;
  }
}

class Components {
  Components({
    dynamic co,
    dynamic no,
    dynamic no2,
    dynamic o3,
    dynamic so2,
    dynamic pm25,
    dynamic pm10,
    dynamic nh3,
  }) {
    _co = co;
    _no = no;
    _no2 = no2;
    _o3 = o3;
    _so2 = so2;
    _pm25 = pm25;
    _pm10 = pm10;
    _nh3 = nh3;
  }

  Components.fromJson(dynamic json) {
    _co = json['co'];
    _no = json['no'];
    _no2 = json['no2'];
    _o3 = json['o3'];
    _so2 = json['so2'];
    _pm25 = json['pm2_5'];
    _pm10 = json['pm10'];
    _nh3 = json['nh3'];
  }
  dynamic _co;
  dynamic _no;
  dynamic _no2;
  dynamic _o3;
  dynamic _so2;
  dynamic _pm25;
  dynamic _pm10;
  dynamic _nh3;

  dynamic get co => _co;
  dynamic get no => _no;
  dynamic get no2 => _no2;
  dynamic get o3 => _o3;
  dynamic get so2 => _so2;
  dynamic get pm25 => _pm25;
  dynamic get pm10 => _pm10;
  dynamic get nh3 => _nh3;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['co'] = _co;
    map['no'] = _no;
    map['no2'] = _no2;
    map['o3'] = _o3;
    map['so2'] = _so2;
    map['pm2_5'] = _pm25;
    map['pm10'] = _pm10;
    map['nh3'] = _nh3;
    return map;
  }
}

class Main {
  Main({
    int? aqi,
  }) {
    _aqi = aqi;
  }

  Main.fromJson(dynamic json) {
    _aqi = json['aqi'];
  }
  int? _aqi;

  int? get aqi => _aqi;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['aqi'] = _aqi;
    return map;
  }
}

class Coord {
  Coord({
    double? lon,
    double? lat,
  }) {
    _lon = lon;
    _lat = lat;
  }

  Coord.fromJson(dynamic json) {
    _lon = json['lon'].toDouble();
    _lat = json['lat'].toDouble();
  }
  double? _lon;
  double? _lat;

  double? get lon => _lon;
  double? get lat => _lat;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['lon'] = _lon;
    map['lat'] = _lat;
    return map;
  }
}

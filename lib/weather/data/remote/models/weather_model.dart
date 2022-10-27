import 'package:weather_app_by_loacation/weather/domain/entities/weather.dart';

class WeatherModel extends Weather {
  WeatherModel({
    required super.cityId,
    required super.id,
    required super.cityName,
    required super.main,
    required super.description,
    required super.pressure,
    required super.tempMain,
    required super.tempMax,
    required super.date,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) => WeatherModel(
        cityName: json['city']['name'].toString(),
        cityId: json['city']['id'].toInt(),
        id: List.from(json['list'].map((e) {
          return e['weather'][0]['id'].toInt();
        })),
        date: List.from(json['list'].map((e) {
          return e['dt_txt'].toString();
        })),
        description: List.from(json['list'].map((e) {
          return e['weather'][0]['description'].toString();
        })),
        main: List.from(json['list'].map((e) {
          return e['weather'][0]['main'].toString();
        })),
        pressure: List.from(json['list'].map((e) {
          return e['main']['pressure'].toInt();
        })),
        tempMain: List<double>.from(json['list'].map((e) {
          return e['main']['temp_min'].toDouble();
        })),
        tempMax: List<double>.from(json['list'].map((e) {
          return e['main']['temp_max'].toDouble();
        })),
      );
}

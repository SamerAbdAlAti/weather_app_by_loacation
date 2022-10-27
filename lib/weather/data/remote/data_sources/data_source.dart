import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:weather_app_by_loacation/core/app_constance.dart';
import 'package:weather_app_by_loacation/weather/data/remote/models/weather_model.dart';

abstract class BaseRemoteDataSource {
  Future<WeatherModel?> getWeatherByLocation(double latitude, double longitude);
}

class RemoteDataSource extends BaseRemoteDataSource {
  @override
  Future<WeatherModel?> getWeatherByLocation(
      double latitude, double longitude) async {
    try {
      var response = await Dio().get(
        '${AppConstance.baseUrl}/forecast?id=524901&lat=$latitude&lon=$longitude&appid=${AppConstance.apiKey}',
      );
      return WeatherModel.fromJson(response.data);
    } catch (e) {
      print(e);
    }
  }
}

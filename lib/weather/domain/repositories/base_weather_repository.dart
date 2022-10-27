import 'package:weather_app_by_loacation/weather/domain/entities/weather.dart';

abstract class BaseWeatherRepository {
  Future<Weather> getWeatherByLocation(double latitude, double longitude);
}

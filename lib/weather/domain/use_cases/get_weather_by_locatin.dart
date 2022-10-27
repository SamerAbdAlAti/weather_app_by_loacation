import 'package:weather_app_by_loacation/weather/domain/entities/weather.dart';
import 'package:weather_app_by_loacation/weather/domain/repositories/base_weather_repository.dart';

class GetWeatherByLocation {
  final BaseWeatherRepository baseWeatherRepository;

  GetWeatherByLocation(this.baseWeatherRepository);

  Future<Weather> execute({
    required double latitude,
    required double longitude,
  }) async {
    return await baseWeatherRepository.getWeatherByLocation(
      latitude,
      longitude,
    );
  }
}

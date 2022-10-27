import 'package:weather_app_by_loacation/weather/data/remote/data_sources/data_source.dart';
import 'package:weather_app_by_loacation/weather/domain/entities/weather.dart';
import 'package:weather_app_by_loacation/weather/domain/repositories/base_weather_repository.dart';

class WeatherRepository implements BaseWeatherRepository {
  final BaseRemoteDataSource baseRemoteDataSource;

  WeatherRepository(this.baseRemoteDataSource);

  @override
  Future<Weather> getWeatherByLocation(
    double latitude,
    double longitude,
  ) async {
    return (await baseRemoteDataSource.getWeatherByLocation(
      latitude,
      longitude,
    ))!;
  }
}

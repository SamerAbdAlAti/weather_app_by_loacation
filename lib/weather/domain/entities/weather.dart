/// أول class نبدأ به في ال clean architecture
///
class Weather {
  final int cityId;
  final List<int> id;
  final String cityName;
  final List<String> main;
  final List<String> description;
  final List<int>? pressure;
  final List<double> tempMain;
  final  List<double> tempMax;
  final List<String> date;

  const Weather({
    required this.cityId,
    required this.id,
    required this.cityName,
    required this.main,
    required this.description,
    required this.pressure,
    required this.tempMain,
    required this.tempMax,
    required this.date,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Weather &&
          runtimeType == other.runtimeType &&
          cityId == other.cityId &&
          id == other.id &&
          cityName == other.cityName &&
          main == other.main &&
          description == other.description &&
          pressure == other.pressure &&
          date == other.date;

  @override
  int get hashCode =>
      cityId.hashCode ^
      id.hashCode ^
      cityName.hashCode ^
      main.hashCode ^
      description.hashCode ^
      pressure.hashCode ^
      date.hashCode;
}

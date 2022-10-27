part of 'app_cubit.dart';
/*############## ملف الحالات حيث شيقوم بالتغيير من AppInitial للحالات الأخرى  #####################*/

@immutable
abstract class AppState {}

class AppInitial extends AppState {}
class GetLocationDataState extends AppState {}
class GetDataAndFillVariableState extends AppState {}
class CacheHelperState extends AppState {}
class findDateState extends AppState {}

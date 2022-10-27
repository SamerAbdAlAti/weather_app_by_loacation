import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:location/location.dart';
import 'package:weather_app_by_loacation/weather/data/local/data_sources/cache_helper.dart';
import 'package:weather_app_by_loacation/weather/data/remote/data_sources/data_source.dart';

import '../../../../../data/repositories/weather_repsitory.dart';
import '../../../../../domain/entities/weather.dart';
import '../../../../../domain/repositories/base_weather_repository.dart';
import '../../../../../domain/use_cases/get_weather_by_locatin.dart';

part 'app_state.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit() : super(AppInitial());


  static AppCubit get(context) => BlocProvider.of(context);
  /*############## متغيرات لتخزيين خطوط الطول ودوائر العرض لإرسالهما بال api  #####################*/

  double? latitude;
  double? longitude;

  /*############## متغييرات لتخزيين القيم القادمة من ال api  #####################*/

  int? cityId;
  List<int>? id;
  String? cityName;
  List<String>? main;
  List<String>? description;
  List<int>? pressure;
  List<String>? date;
  List<double>? tempMax=[];
  List<double>? tempMain;


  /*############## متغيير لتخزيين قيمة ال first list   #####################*/
  int listDateLength = 0;
  String getBasicDate = "";

//for Get Location Data
  void getLocationData() async {
    WidgetsFlutterBinding.ensureInitialized();
    double? latitudeSheared = CacheHelper.getDouble(key: "latitude");
    double? longitudeSheared = CacheHelper.getDouble(key: "latitude");
    /*############## اذا كانت القية فارغة في  ال SharedPreferences  شغل ال location  #####################*/

    if (latitudeSheared == null || longitudeSheared == null) {
      Location location = Location();

      bool _serviceEnabled;
      PermissionStatus _permissionGranted;
      LocationData _locationData;

      _serviceEnabled = await location.serviceEnabled();
      if (!_serviceEnabled) {
        _serviceEnabled = await location.requestService();
        if (!_serviceEnabled) {
          return;
        }
      }

      _permissionGranted = await location.hasPermission();
      if (_permissionGranted == PermissionStatus.denied) {
        _permissionGranted = await location.requestPermission();
        if (_permissionGranted != PermissionStatus.granted) {
          return;
        }
      }

      /*##############  استدع ال location و استخرج خطوط الطول و دوائر العرض وخزنها في المتغيرات في الأعلى  #####################*/

      _locationData = await location.getLocation();
      latitude = _locationData.latitude;
      longitude = _locationData.longitude;
      /*##############  خزن قيمة خطوط الطول ودوائر العرض في ال SharedPreferences   #####################*/

      await CacheHelper.putDouble(key: "latitude", value: latitude);
      await CacheHelper.putDouble(key: "longitude", value: longitude);

      emit(GetLocationDataState());
    }

    // if anyThing not null
    /*############## اذا لم تكن القيم في  ال SharedPreferences == null نفذ ال function الخاص بالإستدعاء من ال api  #####################*/

    if (latitude != null ||
        longitude != null ||
        latitudeSheared != null ||
        longitudeSheared != null) getDataAndFillVariable();
    emit(CacheHelperState());
  }

  // for fill data to variables
  Future<void> getDataAndFillVariable() async {
    BaseRemoteDataSource baseRemoteDataSource = RemoteDataSource();
    BaseWeatherRepository baseWeatherRepository =
        WeatherRepository(baseRemoteDataSource);

    double? getLatitude = CacheHelper.getDouble(key: "latitude");
    double? getLongitude = CacheHelper.getDouble(key: "longitude");
    CacheHelper.getDouble(key: "longitude");
    Weather weather = await GetWeatherByLocation(baseWeatherRepository).execute(
      latitude: getLatitude ?? latitude!,
      longitude: getLongitude ?? longitude!,
    );

    cityName = weather.cityName;
    id = weather.id;
    main = weather.main;
    description = weather.description;
    pressure = weather.pressure;
    tempMain = weather.tempMain;
    tempMax = weather.tempMax;
    date = weather.date;
    /*############## ال loop الخاص بجلب اول طول اول list  #####################*/

    for (int x = 0; x < date!.length.round(); x++) {
      DateTime dateTime = DateTime.now();
      if (date![x].toString().substring(0, 11) ==
          dateTime.toString().substring(0, 11)) {
        listDateLength++;
      }
    }

    emit(GetDataAndFillVariableState());
  }
}

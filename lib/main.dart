import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:size_builder/size_builder.dart';
import 'package:status_bar_control/status_bar_control.dart';
import 'package:weather_app_by_loacation/weather/data/local/data_sources/cache_helper.dart';
import 'package:weather_app_by_loacation/weather/presentation/manager/sheare/cubit/app_cubit/app_cubit.dart';
import 'package:weather_app_by_loacation/weather/presentation/manager/sheare/cubit/my_bloc_opserver/my_bloc_opserver.dart';
import 'package:weather_app_by_loacation/weather/presentation/manager/sheare/style/app_style.dart';
import 'package:weather_app_by_loacation/weather/presentation/pages/home_page.dart';

void main() async {
  /*############## للتأكد من انه سيتم تطبيق كل ما في داخل ال main #####################*/
  WidgetsFlutterBinding.ensureInitialized();
  /*############## استدعاء ما داخل الذاكرة #####################*/

  await CacheHelper.init();
  /*############## استدعاءMyBlocObserver الخاصة بال bloc #####################*/

  Bloc.observer = MyBlocObserver();
  AppCubit();

  /*############## أجعل ال  status bar شفاف و تأكد من ظهوره  #####################*/

  await StatusBarControl.setColor(Colors.white.withOpacity(0.0));
  await StatusBarControl.setFullscreen(false);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    /*############## استدعاء ال bloc provider  #####################*/

    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (BuildContext context) => AppCubit()..getLocationData(),
        )
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        /*############## استدعاءال ThemeData من class ال AppStyle داخل ملف ال style  #####################*/

        theme: AppStyle.lightTheme,
        darkTheme: AppStyle.darkTheme,
        home: const MyHomePage(),
      ),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*############## ابعت ال context الى class ال MobileAppSize ليقوم بالحساب  #####################*/

    MobileAppSize().init(context);
    return const Material(
      child: HomePage(),
    );
  }
}

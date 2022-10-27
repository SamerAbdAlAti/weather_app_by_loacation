import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:size_builder/size_builder.dart';
import 'package:weather_app_by_loacation/weather/presentation/manager/sheare/cubit/app_cubit/app_cubit.dart';

class AppComponants {
  static Widget tempWidget({
    IconData icon = Icons.arrow_drop_down,
    String? text,
  }) =>
      BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);

          return Row(
            children: [
              Text(
                '${text ?? ((cubit.tempMain![0] - 273).round())}°',
                style: const TextStyle(
                  fontFamily: 'Caviar Dreams',
                  fontSize: 17,
                  color: Color(0xffffffff),
                  letterSpacing: 0.8500000000000001,
                ),
                softWrap: false,
              ),
              Icon(
                icon,
                color: Colors.white,
                size: MobileAppSize.Size25,
              ),
            ],
          );
        },
      );

  static Widget buildListWeather({
    required int index,
  }) =>
      BlocConsumer<AppCubit, AppState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          AppCubit cubit = AppCubit.get(context);
          int indexValue = index == 0
              ? 0
              : index == 1
                  ? (cubit.listDateLength)
                  : index == 2
                      ? (cubit.listDateLength + 8)
                      : index == 3
                          ? (cubit.listDateLength + 16)
                          : index == 4
                              ? (cubit.listDateLength + 24)
                              : index;

          String textFormat = cubit.date![indexValue];
          final DateTime now = DateTime.parse(textFormat);
          final DateFormat formatter = DateFormat('EEEE');
          final String formatted = formatter.format(now);
          return Padding(
            padding: EdgeInsets.all(MobileAppSize.Height14!).copyWith(
                right: MobileAppSize.Height28!, left: MobileAppSize.Height28!),
            child: Row(
              children: [
                Text(
                  formatted.toString(),
                  style:  TextStyle(
                    fontFamily: 'Futura PT',
                    fontSize: MobileAppSize.Height17,
                    color: const Color(0xff697f97),
                    fontWeight: FontWeight.w300,
                  ),
                  softWrap: false,
                ),
                const Spacer(),
                Text(
                  '${(cubit.tempMax![indexValue] - 273).floor()}°',
                  style: TextStyle(
                    fontFamily: 'Futura PT',
                    fontSize: MobileAppSize.Height18,
                    color: const Color(0xff697f97),
                    fontWeight: FontWeight.w300,
                  ),
                  softWrap: false,
                ),
                SizedBox(
                  width: MobileAppSize.Width12,
                ),
                getWeatherIcon(index: indexValue),
              ],
            ),
          );
        },
      );

  static Widget getWeatherIcon({required index}) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        AppCubit cubit = AppCubit.get(context);
        int indexValue = index.round();
        final double size = MobileAppSize.Height30!;
        if (cubit.description![indexValue] == "clear sky") {
          return SvgPicture.asset(
            "assets/images/sunny_icon.svg",
            height: size,
          );
        } else if (cubit.description![indexValue] == "light rain") {
          return SvgPicture.asset(
            "assets/images/rain_with_sunny_icon.svg",
            height: size,
          );
        } else if (cubit.description![indexValue] == "scattered clouds") {
          return SvgPicture.asset(
            "assets/images/could_day___icon.svg",
            height: size,
          );
        } else if (cubit.description![indexValue] == "few clouds") {
          return SvgPicture.asset(
            "assets/images/sunny_icon.svg",
            height: size,
          );
        } else {
          return SvgPicture.asset(
            "assets/images/rain_icon.svg",
            height: size,
          );
        }
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:size_builder/size_builder.dart';
import 'package:weather_app_by_loacation/weather/presentation/manager/sheare/componants/app_componants.dart';
import 'package:weather_app_by_loacation/weather/presentation/manager/sheare/cubit/app_cubit/app_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /*############## ابعت context الى class MobileAppSize  #####################*/

    MobileAppSize().init(context);

    /*############## استدع bloc consumer لعمل listen على ال states   #####################*/

    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        /*############## لتقصيير الاستدعاء من داخل class ال cubit   #####################*/

        AppCubit cubit = AppCubit.get(context);

        return Scaffold(
          /*############## اذا كانت القيم القادمة من ال api ليست فارغة ارجع القيم التالية  #####################*/

          body: cubit.date != null
              ? Container(
                  width: double.maxFinite,

                  /*############## بدل ما بين tow boxDeclarations بحسب القيم القادمة من ال main   #####################*/

                  decoration: cubit.main![0] != "Clear"
                      ? const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                            colors: [Color(0xff162840), Color(0xff3d6684)],
                            stops: [0.0, 1.0],
                          ),
                        )
                  /*##############اذا لم يتحقق   #####################*/

                      : const BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment(0.0, -1.0),
                            end: Alignment(0.0, 1.0),
                            colors: [Color(0xfffea085), Color(0xfff6ce64)],
                            stops: [0.0, 1.0],
                          ),
                        ),
                  /*############## من هنا يبدأ ال design   #####################*/

                  /*############## اعمل طبقات   #####################*/

                  child: Stack(
                    alignment: AlignmentDirectional.topCenter,
                    children: [
                      /*##############الطبقة الأولى   #####################*/

                      Column(
                        children: [
                          SizedBox(
                            height: MobileAppSize.Height65,
                          ),
                          /*################# بدل الصورة بحسب القيم القادمة من ال main   #####################*/

                          cubit.main![0] != "Clear"
                              ? SvgPicture.asset(
                                  "assets/images/background_light.svg",
                                  fit: BoxFit.cover,
                                  height: MobileAppSize.Height447,
                                )
                          /*##############اذا لم يتحقق   #####################*/

                              : SvgPicture.asset(
                                  "assets/images/clear_bakeground.svg",
                                  fit: BoxFit.cover,
                                  alignment: AlignmentDirectional.topCenter,
                                  height: MobileAppSize.Height466,
                                ),
                        ],
                      ),
                      /*##############اذا لم تكن القيمة فارغة return the widget    #####################*/

                      cubit.date != null
                          ? Column(
                              children: [
                                SizedBox(
                                  height: MobileAppSize.Height65,
                                ),
                                Text(
                                  cubit.cityName!,
                                  style: TextStyle(
                                    fontSize: MobileAppSize.Size22,
                                    fontFamily: 'Futura PT',
                                    color: const Color(0xffffffff),
                                    letterSpacing: 1.76,
                                    fontWeight: FontWeight.w300,
                                  ),
                                  softWrap: false,
                                ),
                                SizedBox(
                                  height: MobileAppSize.Height160,
                                ),
                                Text(
                                  '${(((cubit.tempMax![0] - 273).round() + (cubit.tempMain![0] - 273).round()) / 2).floor()}°',
                                  style: TextStyle(
                                    fontFamily: 'Caviar Dreams',
                                    fontSize: MobileAppSize.Size56,
                                    color: Color(0xffffffff),
                                    letterSpacing: 2.8000000000000003,
                                    fontWeight: FontWeight.w700,
                                  ),
                                  softWrap: false,
                                ),
                                Padding(
                                  padding: EdgeInsets.only(
                                    top: MobileAppSize.Height14!,
                                    right: MobileAppSize.Width30!,
                                    left: MobileAppSize.Width30!,
                                  ),
                                  child: Row(
                                    children: [
                                      AppComponants.tempWidget(),
                                      Expanded(
                                        child: Center(
                                          child: Container(
                                            child: Text(
                                              '${cubit.main![0]}\t\t\t\t\t',
                                              style: TextStyle(
                                                fontFamily: 'Futura PT',
                                                fontSize: MobileAppSize.Size26,
                                                color: const Color(0xffffffff),
                                                fontWeight: FontWeight.w300,
                                              ),
                                              softWrap: false,
                                            ),
                                          ),
                                        ),
                                      ),
                                      AppComponants.tempWidget(
                                        icon: Icons.arrow_drop_up,
                                        text:
                                            "${((cubit.tempMax![0] - 273).round())}",
                                      )
                                    ],
                                  ),
                                ),
                                const Spacer(),
                              ],
                            )
                      /*##############اذا لم يتحقق   #####################*/

                          : Container(),

                      /*##############القسم السفلي   #####################*/

                      Column(
                        children: [
                          /*##############اجعل كل شيء في الأسفل   #####################*/

                          const Spacer(),

                          /*##############اعمل طبقات  #####################*/

                          Stack(
                            alignment: AlignmentDirectional.bottomCenter,
                            children: [
                              /*##############الجزء السفلي عبارة عن svg image  #####################*/

                              ClipPath(
                                clipper: MyCustomClipper(),
                                clipBehavior: Clip.antiAliasWithSaveLayer,
                                child: Container(
                                  color: Colors.white,
                                  width: MobileAppSize.screenWidth,

                                  height: MobileAppSize.Height360 ,
                                ),
                              ),
                              /*##############الطبقة الثانية  #####################*/

                              SizedBox(
                                height: MobileAppSize.Height345,
                                child: Column(
                                  children: [
                                    /*##############اذا لم تكن القيمة القادمة من ال api فارغة ارجع البيانات و اعرضها في مكانها  #####################*/

                                    cubit.date != null
                                        ? Expanded(
                                            child: ListView.builder(
                                              itemBuilder: (context, index) =>
                                              /*##############اعرض طقس 5 ايام قادمة #####################*/
                                              /*##############ال widget المتكرر موجود في class ال AppComponants #####################*/

                                              AppComponants
                                                      .buildListWeather(
                                                          index: index),
                                              itemCount: 5,
                                              /*##############اذا كلن يوجد scroll اجعل ال scroll يمغط  #####################*/

                                              physics:
                                                  const BouncingScrollPhysics(),
                                              shrinkWrap: true,
                                            ),
                                          )
                                    /*##############اذا لم يتحقق الشرط #####################*/

                                        : const Expanded(
                                            child: Center(
                                                child:
                                                    CircularProgressIndicator()))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                )

          /*##############اذا لم يتحقق الشرط #####################*/

              : Container(
                  color: Colors.white,
                  child: const Center(
                    child: CircularProgressIndicator(
                      color: Color(0xfffea085),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
/*##############Clip Path للقطعة السفلية #####################*/
/*##############الموقع لعمل القياسات #####################*/
/*############## https://shapemaker.web.app/#/     #####################*/

class MyCustomClipper extends CustomClipper<Path>{
  @override
  Path getClip(Size size) {
   double w=size.width;
   double h=size.height;

   Path path = Path();
   path.moveTo(0.0,size.height);
   path.lineTo(0.0,0.0);
   path.quadraticBezierTo(size.width*0.3014583,size.height*0.1767857,size.width*0.4991667,size.height*0.0928571);
   path.quadraticBezierTo(size.width*0.7522917,size.height*-0.0339286,size.width,size.height*0.1214286);
   path.lineTo(size.width*0.9983333,size.height*0.9985714);
   path.lineTo(0.0,size.height);
   path.close();

   return path;

  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
   return false;
  }
}





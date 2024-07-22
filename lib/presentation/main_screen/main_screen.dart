//import 'dart:ffi';

//import 'package:flutter/foundation.dart';
//import 'dart:html';

import 'package:conveyor_app/routes/route_name.dart';
import 'package:get/get.dart';
//import 'package:awesome_notifications/awesome_notifications.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:conveyor_app/core/app_export.dart';
import 'package:conveyor_app/widgets/custom_elevated_button.dart';
//import 'package:get/get.dart';
import 'package:intl/intl.dart';
//import 'package:conveyor_app/main.dart';

import '../../models/model.dart';
//import '../../main.dart';
import '../../controllers/sensor.dart';
import '../../controllers/user_controller.dart';
import 'dart:async';

class MainScreen extends StatelessWidget {
  // const MainScreen({Key? key}) : super(key: key);
  final UserController userController = Get.put(UserController());
  final SensorController sensorController = Get.find();

  bool isWarning = true;
  bool hasShownNotification = false;

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: SingleChildScrollView(
              child: Container(
                  width: SizeUtils.width,
                  height: SizeUtils.height,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment(0, 0.5),
                          end: Alignment(1, 0.5),
                          colors: [
                        appTheme.teal400,
                        appTheme.teal30001,
                        appTheme.teal300
                      ])),
                  child: Container(
                      width: double.maxFinite,
                      padding:
                          EdgeInsets.symmetric(horizontal: 29.h, vertical: 26.v),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(height: 10.v),
                            _buildMonitoringMulticonveyorInline(context),
                            SizedBox(height: 5.v),
                            _welcomeName(context),
                            SizedBox(height: 30.v),
                            _buildDateTime(context),
                            SizedBox(height: 5.v),
                            _buildImageStack(context),
                            SizedBox(height: 30.v),
                            _buildSpeedConveyorOne(context),
                          ]))),
            ),
            bottomNavigationBar: _buildHISTORY(context)));
  }

  Widget _welcomeName(BuildContext context) {
    userController.checkLoggedIn();
    return Obx(() => Padding(
      padding: EdgeInsets.only(left: 7.h, right: 5.h),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
          "Welcome, ${userController.username.value} (${userController.role.value})",  style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
          //  Text(
          // "Role: ${userController.role.value}",  style: TextStyle(
          //                 fontSize: 18,
          //                 color: Colors.white,
          //                 fontWeight: FontWeight.bold)),
          userController.role.value == "admin"
            ? GestureDetector(
              onTap: (){
                Get.offAllNamed(RouteName.addUser);
              },
              child: Container(
                  height: 30,
                  width: 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color.fromARGB(255, 2, 19, 252),
                  ),
                  child: Center(
                    child: Text("Add User", style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),),
                  ),
                ),
            )
          : SizedBox.shrink(),

        ],
      ),
    ));
  }

  /// Section Widget
  Widget _buildMonitoringMulticonveyorInline(BuildContext context) {
    final UserController userController = Get.put(UserController());
    return SingleChildScrollView(
      child: Padding(
          padding: EdgeInsets.only(left: 7.h, right: 5.h),
          child:
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Padding(
                padding: EdgeInsets.only(top: 20.v),
                child: Text("Monitoring Multiconveyor Inline",
                    style: TextStyle(
                        fontSize: 30,
                        color: Colors.white,
                        fontWeight: FontWeight.bold))),
            CustomElevatedButton(
              buttonTextStyle: TextStyle(
                color: Colors.white
              ),
              buttonStyle: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.redAccent)
              ),
                height: 30.h,
                width: 60.h,
                text: "LOGOUT",
                margin: EdgeInsets.only(top: 15.v),
                onPressed: () {
                  // onTapLOGOUT(context);
                  userController.logout();
                  Get.offAllNamed( RouteName.thumbnailScreen);
                
                })
          ])),
    );
  }

  /// Section Widget
  Widget _buildDateTime(BuildContext context) {
    return StreamBuilder(
      stream: Stream.periodic(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        return Padding(
            padding: EdgeInsets.symmetric(horizontal: 11.h),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    //sensorController.status == true ? 
                    DateFormat.yMd().format(DateTime.now())
                    //: "PLANT NOT CONNECTED"
                    ,
                      style: TextStyle(fontSize: 13,
                      color: 
                      //sensorController.status == false ? 
                      Colors.black 
                      //: Colors.deepOrange
                      )),
                      // CustomTextStyles.bodySmallInterBlack900),       
                  Text(
                    //sensorController.status == true ? 
                    DateFormat.Hms().format(DateTime.now()) 
                    //: ""
                    ,
                      style: TextStyle(fontSize: 13,
                      color: Colors.black))
                      //CustomTextStyles.bodySmallInterBlack900)
                ]));
      },
    );
  }

  Widget _buildImageStack(BuildContext context) {
    return StreamBuilder<List<Sensor>>(
        stream: sensorController.sensorStreamLast,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: CustomImageView(
                    imagePath: ImageConstant.imgLoading,
                     height: 100.v,
                    width: 70.h,
                    ),
              //child: Text("Loading..."),
            );
          }

          // Ambil sensor terakhir yang tidak null
          final Sensor sensor1 = snapshot.data!.lastWhere((sensor) =>sensor.data.any((datum) => datum.ind1 != null));
          final Sensor sensor2 = snapshot.data!.lastWhere((sensor) =>sensor.data.any((datum) => datum.ind2 != null));
          final Sensor sensor3 = snapshot.data!.lastWhere((sensor) =>sensor.data.any((datum) => datum.kond != null));
          final Sensor sensor4 = snapshot.data!.lastWhere((sensor) =>sensor.data.any((datum) => datum.kec1 != null));
          final Sensor sensor5 = snapshot.data!.lastWhere((sensor) =>sensor.data.any((datum) => datum.kec2 != null));
          // final Sensor sensor2 = snapshot.data!.lastWhere((sensor) =>
          //     sensor.data.any((datum) =>
          //         datum.proximity3 != null && datum.proximity4 != null));
          // final Sensor sensor3 = snapshot.data!.last;
          // Ambil nilai proximity1 dan proximity2 yang tidak null
          final Datum datum1 = sensor1.data.firstWhere(((datum) => datum.ind1 != null));
          final Datum datum2 = sensor2.data.firstWhere(((datum) => datum.ind2 != null));
          final Datum datum3 = sensor3.data.firstWhere(((datum) => datum.kond != null));
          final Datum datum4 = sensor4.data.firstWhere(((datum) => datum.kec1 != null));
          final Datum datum5 = sensor5.data.firstWhere(((datum) => datum.kec2 != null));
          // final Datum datum2 = sensor2.data.firstWhere(
          //     (datum) => datum.proximity3 != null && datum.proximity4 != null);
          // final Datum datum3 = sensor3.data.firstWhere(
          //     (datum) => datum.kondisi != null);
          // final Datum datum3 = sensor3.data.first;

          // Mengatur warna berdasarkan nilai proximity1 dan proximity2 yang tidak null
          Color colorind1 = getColorind1(datum1);
          Color colorind2 = getColorind2(datum2);
          Color colorkond = getColorkond(datum3);
          String imagearrow1 = getImageArrow1(datum4);
          String imagearrow2 = getImageArrow2(datum5);

          isWarning = !isWarning;

          return SizedBox(
              height: 140.v,
              width: 600.h,
              child: Stack(children: [
                Align(
                  alignment: Alignment.topRight,
                  child: 
                  CustomImageView(
                    imagePath: ImageConstant.imggambarkonveyor2,
                    height: 118.v,
                    width: 291.h,
                    //margin: EdgeInsets.only(bottom: 30)
                    ),),
                // Align(
                //   alignment: Alignment.topRight,
                //   child: Container(
                //     height: 120.v,
                //     width: 291.h,
                //     decoration: BoxDecoration(
                //         borderRadius: BorderRadius.circular(10),
                //         gradient: LinearGradient(
                //             begin: Alignment(0, 0),
                //             end: Alignment(0, 0),
                //             colors: [
                //               Colors.white,
                //               Colors.grey,
                //               Colors.white,
                //             ])),
                //   ),),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: 
                  CustomImageView(
                    imagePath: ImageConstant.imggambarkonveyor1,
                    height: 118.v,
                    width: 291.h,
                    margin: EdgeInsets.only(bottom: 2),
                    ),),
                  // Container(
                  //     height: 120.v,
                  //     width: 291.h,
                  //     decoration: BoxDecoration(
                  //       color: Colors.white,
                  //       borderRadius: BorderRadius.circular(10),
                  //     )),
                
                Align(
                    child: Container(
                        alignment: Alignment.center,
                        height: 110.v,
                        width: 5.h,
                        decoration: BoxDecoration(
                            color: colorkond,
                            borderRadius: BorderRadius.circular(5.h)))),
                Align(
                    child: Container(
                        alignment: Alignment.center,
                        height: 50.v,
                        width: 40.h,
                        margin: EdgeInsets.only(right: 150),
                        decoration: BoxDecoration(
                            color: colorind1,
                            borderRadius: BorderRadius.circular(5.h)))),
                Align(
                    child: Container(
                        alignment: Alignment.center,
                        height: 50.v,
                        width: 40.h,
                        margin: EdgeInsets.only(left: 150),
                        decoration: BoxDecoration(
                            color: colorind2,
                            borderRadius: BorderRadius.circular(5.h)))),
                CustomImageView(
                    imagePath: imagearrow1,
                    height: 50.v,
                    width: 150.h,
                    alignment: Alignment.topLeft,
                    margin: EdgeInsets.only(top: 42.v)),
                // CustomImageView(
                //     imagePath: ImageConstant.imgpanahtidakbergerak,
                //     height: 25.v,
                //     width: 75.h,
                //     alignment: Alignment.bottomLeft,
                //     margin: EdgeInsets.only(bottom: 40.v)),
                CustomImageView(
                    imagePath: imagearrow2,
                    height: 50.v,
                    width: 150.h,
                    alignment: Alignment.topRight,
                    margin: EdgeInsets.only(right: 18.h, top: 42.v)),
                // CustomImageView(
                //     imagePath: ImageConstant.imgHttpsLottief25x75,
                //     height: 25.v,
                //     width: 75.h,
                //     alignment: Alignment.bottomRight,
                //     margin: EdgeInsets.only(bottom: 40.v))
              ]));
        });
  }

  Color getColorind1(Datum datum) {
    // Mengatur warna berdasarkan nilai proxymiti1
    if (datum.ind1 == 0) {
      return Colors.grey;
    } else if (datum.ind1 == 1) {
      return Colors.red;
    } 
    else if (datum.ind1 == 2) {
      return Colors.green;
    }
    else {
      return Colors.transparent;
    }
  }

  Color getColorind2(Datum datum) {
    // Mengatur warna berdasarkan nilai proxymiti1
    if (datum.ind2 == 0) {
      return Colors.grey;
    } else if (datum.ind2 == 1) {
      return Colors.red;
    } 
    else if (datum.ind2 == 2) {
      return Colors.green;
    }
    else {
      return Colors.transparent;
    }
  }

// bool isWarning = false;
  Color getColorkond(Datum datum) {
    if (datum.kond == 1) {
      if(hasShownNotification == false){
        //showWarningNotification();
      hasShownNotification = true;
      }
            return isWarning ? Colors.red : Colors.transparent;
    } else if (datum.kond == 0) {
      hasShownNotification = false;
      return Colors.green;
    } else {
      return Colors.transparent;
    }
  }

  // void showWarningNotification() {
  //   AwesomeNotifications().createNotification(
  //     content: NotificationContent(
  //       id: 10,
  //       channelKey: 'basic_channel',
  //       title: 'Warning!',
  //       body: 'Condition has triggered a warning!',
  //       icon: 'resource://mipmap/ic_launcher',
  //       notificationLayout: NotificationLayout.Default
  //     )
  //   );
  // }
  String getImageArrow1(Datum datum) {
    if (datum.kec1 == 0) {
      return ImageConstant.imgpanahtidakbergerak;
    } else if (datum.kec1 != null) {
      return ImageConstant.imgpanahbergerak;
    } 
    else {
      return ImageConstant.imgpanahtidakbergerak;
    }
  }
  String getImageArrow2(Datum datum) {
    if (datum.kec2 == 0) {
      return ImageConstant.imgpanahtidakbergerak;
    } else if (datum.kec2 != null) {
      return ImageConstant.imgpanahbergerak;
    } 
    else {
      return ImageConstant.imgpanahtidakbergerak;
    }
  }

  /// Section Widget
  Widget _buildSpeedConveyorOne(BuildContext context) {
          return Padding(
              padding: EdgeInsets.symmetric(horizontal: 11.h),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Padding(
                    padding: EdgeInsets.only(top: 4.v, bottom: 5.v),
                    child: Text("Speed Conveyor 1",
                        style: CustomTextStyles.bodySmallIstokWebWhiteA700)),
                Padding(
                    padding: EdgeInsets.only(left: 20.h),
                    child: _buildFive1(context,
                        //zipcode: datum.kec1.toString(), rpm: "cm/min"
                        )),
                Spacer(),
                SizedBox(
                    width: 250.h,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.v, vertical: 4.v),
                              child: Text("Speed Conveyor 2",
                                  style: CustomTextStyles
                                      .bodySmallIstokWebWhiteA700)),
                          _buildFive2(context,
                              //zipcode: datum.kec2.toString(), rpm: "cm/min"
                              )
                        ]))
              ]));
  }

  Color getColorkec1(Datum datum) {
    // Mengatur warna berdasarkan nilai proxymiti1
    if (datum.kec1 !> 0) {
      return Colors.black;
    } 
    else if (datum.kec1 == 0) {
      if (datum.startA != 0 || datum.startB !=0){
        return Colors.orange;  
      }
      return Colors.black;
    }
    else {
      return Colors.transparent;
    }
  }
  Color getColorkec2(Datum datum) {
    // Mengatur warna berdasarkan nilai proxymiti1
    if (datum.kec2 !> 0) {
      return Colors.black;
    } 
    else if (datum.kec2 == 0) {
      if (datum.startA != 0 || datum.startB !=0){
        return Colors.orange;  
      }
      return Colors.black;
    }
    else {
      return Colors.transparent;
    }
  }
  /// Section Widget
  Widget _buildHISTORY(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CustomElevatedButton(
            height: 25.h,
            width: 100.h,
            text: "HISTORY",
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(
                //left: 267.h, right: 267.h,
                bottom: 50.v),
            onPressed: () {
              onTapHISTORY(context);
            }),
            SizedBox(width: 200,),
        CustomElevatedButton(
            height: 25.h,
            width: 100.h,
            text: "COUNTER",
            alignment: Alignment.bottomCenter,
            margin: EdgeInsets.only(
                //left: 267.h, right: 267.h,
                bottom: 50.v),
            onPressed: () {
              onTapCOUNTER(context);
            }),
      ],
    );
  }

  /// Common widget
  Widget _buildFive1(
    BuildContext context, 
    //{required String zipcode,
    //required String rpm,}
    ) {
    return StreamBuilder<List<Sensor>>(
        stream: sensorController.sensorStreamLast,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: CustomImageView(
                    imagePath: ImageConstant.imgLoading,
                    height: 50.v,
                    width: 50.h,
                    ),
            );
          }
          final Sensor sensor = snapshot.data!.lastWhere((sensor) => sensor.data.any((datum) => datum.kec1 != null));
          final Datum datum = sensor.data.firstWhere((datum) => datum.kec1 != null && datum.startA != null && datum.startB != null);
          Color colorkec1 = getColorkec1(datum);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorkec1,
          ),
          color: Colors.white,
        )
        //AppDecoration.outlineLightBlue
        ,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 2.v),
              child: Text(datum.kec1.toString(),
                  style: CustomTextStyles.bodySmallIstokWebBlack900
                      .copyWith(color: colorkec1))),
          Padding(
              padding: EdgeInsets.only(left: 4.h, top: 4.v),
              child: Text("cm/min",
                  style: CustomTextStyles.bodySmallIstokWebBlack900
                      .copyWith(color: appTheme.black900)))
        ]));});
  }

Widget _buildFive2(
    BuildContext context, 
    //{required String zipcode,
    //required String rpm,}
    ) {
    return StreamBuilder<List<Sensor>>(
        stream: sensorController.sensorStreamLast,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: CustomImageView(
                    imagePath: ImageConstant.imgLoading,
                    height: 50.v,
                    width: 50.h,
                    ),
            );
          }
          final Sensor sensor = snapshot.data!.lastWhere((sensor) => sensor.data.any((datum) => datum.kec2 != null));
          final Datum datum = sensor.data.firstWhere((datum) => datum.kec2 != null && datum.startA != null && datum.startB != null);
          Color colorkec2 = getColorkec2(datum);
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: colorkec2,
          ),
          color: Colors.white,
        )
        //AppDecoration.outlineLightBlue
        ,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 2.v),
              child: Text(datum.kec2.toString(),
                  style: CustomTextStyles.bodySmallIstokWebBlack900
                      .copyWith(color: colorkec2))),
          Padding(
              padding: EdgeInsets.only(left: 4.h, top: 4.v),
              child: Text("cm/min",
                  style: CustomTextStyles.bodySmallIstokWebBlack900
                      .copyWith(color: appTheme.black900)))
        ]));});
  }
  /// Navigates to the loginScreen when the action is triggered.
  // onTapLOGOUT(BuildContext context) {
  //   Navigator.pushNamed(context, AppRoutes.thumbnailScreen);
  // }

  /// Navigates to the historyScreen when the action is triggered.
  onTapHISTORY(BuildContext context) {
    Get.offAllNamed(RouteName.historyScreen);
    // Navigator.pushNamed(context, AppRoutes.historyScreen);
  }
  onTapCOUNTER(BuildContext context) {
    Get.offAllNamed(RouteName.counterScreen);
    // Navigator.pushNamed(context, AppRoutes.historyScreen);
  }
}

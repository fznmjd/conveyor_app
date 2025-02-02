//import 'dart:ffi';

//import 'package:flutter/foundation.dart';
//import 'dart:html';

import 'package:conveyor_app/routes/route_name.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
//import 'package:flutter_svg_provider/flutter_svg_provider.dart' as fs;
import 'package:conveyor_app/core/app_export.dart';
import 'package:conveyor_app/widgets/custom_elevated_button.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:conveyor_app/main.dart';

import '../../models/model.dart';
import '../../main.dart';
import '../../controllers/sensor.dart';
import '../../controllers/user_controller.dart';
import 'dart:async';

class MainScreenOperator extends StatelessWidget {
  // const MainScreen({Key? key}) : super(key: key);
  final UserController userController = Get.put(UserController());
  final SensorController sensorController = Get.find();

  bool isWarning = true;

  @override
  Widget build(BuildContext context) {
   
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            body: Container(
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
                          SizedBox(height: 30.v),
                          _buildMonitoringMulticonveyorInline(context),
                          SizedBox(height: 5.v),
                          _welcomeName(context),
                          SizedBox(height: 30.v),
                          _buildDateTime(context),
                          SizedBox(height: 30.v),
                          _buildImageStack(context),
                          SizedBox(height: 30.v),
                          _buildSpeedConveyorOne(context),
                        ]))),
            ));
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
          "Selamat Datang, ${userController.username.value}",  style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
          Text(
          "Role: ${userController.role.value}",  style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
        ],
      ),
    ));
  }

  /// Section Widget
  Widget _buildMonitoringMulticonveyorInline(BuildContext context) {
    final UserController userController = Get.put(UserController());
    return Padding(
        padding: EdgeInsets.only(left: 7.h, right: 5.h),
        child:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Padding(
              padding: EdgeInsets.only(bottom: 10.v),
              child: Text("Monitoring Multiconveyor Inline",
                  style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold))),
          CustomElevatedButton(
              height: 25.h,
              width: 80.h,
              text: "LOGOUT",
              margin: EdgeInsets.only(top: 15.v),
              onPressed: () {
                // onTapLOGOUT(context);
                userController.logout();
                Get.offAllNamed( RouteName.thumbnailScreen);
              
              })
        ]));
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
                  Text(DateFormat.yMd().format(DateTime.now()),
                      style: TextStyle(fontSize: 13,
                      color: Colors.black)),
                      // CustomTextStyles.bodySmallInterBlack900),
                  Text(DateFormat.Hms().format(DateTime.now()),
                      style: TextStyle(fontSize: 13,
                      color: Colors.black))
                      //CustomTextStyles.bodySmallInterBlack900)
                ]));
      },
    );
  }

  Widget _buildImageStack(BuildContext context) {
    return StreamBuilder<List<Sensor>>(
        stream: sensorController.sensorStream,
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
      // Mengembalikan warna merah jika ada peringatan, dan transparan jika tidak
      return isWarning ? Colors.red : Colors.transparent;
    } else if (datum.kond == 0){
      return Colors.green;
    }
    else{
      return Colors.transparent;
    }
  }
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
    return StreamBuilder<List<Sensor>>(
        stream: sensorController.sensorStream,
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
              child: CustomImageView(
                    imagePath: ImageConstant.imgLoading,
                    height: 50.v,
                    width: 50.h,
                    // margin: EdgeInsets.only(bottom: 2),
                    ),
              //child: Text("Loading..."),
            );
          }

          // final List<Sensor> filteredSensors = snapshot.data!
          //     .lastWhere((sensor) => sensor.data.any((datum) =>
          //         datum.kecepatan1 != null && datum.kecepatan2 != null))
          //     .toList();
          final Sensor sensor = snapshot.data!.lastWhere((sensor) => sensor.data.any((datum) => datum.kec1 != null && datum.kec2 != null));
          final Datum datum = sensor.data.firstWhere((datum) => datum.kec1 != null && datum.kec2 != null);
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
                    child: _buildFive(context,
                        zipcode: datum.kec1.toString(), rpm: "cm/s")),
                Spacer(),
                SizedBox(
                    width: 231.h,
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 40.v, vertical: 4.v),
                              child: Text("Speed Conveyor 2",
                                  style: CustomTextStyles
                                      .bodySmallIstokWebWhiteA700)),
                          _buildFive(context,
                              zipcode: datum.kec2.toString(), rpm: "cm/s")
                        ]))
              ]));
        });
  }

  /// Common widget
  Widget _buildFive(
    BuildContext context, {
    required String zipcode,
    required String rpm,
  }) {
    return Container(
        padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
        decoration: BoxDecoration(
          border: Border.all(
            width: 1,
            color: Colors.black,
          ),
          color: Colors.white,
        )
        //AppDecoration.outlineLightBlue
        ,
        child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
              padding: EdgeInsets.symmetric(vertical: 2.v),
              child: Text(zipcode,
                  style: CustomTextStyles.bodySmallIstokWebBlack900
                      .copyWith(color: appTheme.black900))),
          Padding(
              padding: EdgeInsets.only(left: 4.h, top: 4.v),
              child: Text(rpm,
                  style: CustomTextStyles.bodySmallIstokWebBlack900
                      .copyWith(color: appTheme.black900)))
        ]));
  }

  /// Navigates to the loginScreen when the action is triggered.
  // onTapLOGOUT(BuildContext context) {
  //   Navigator.pushNamed(context, AppRoutes.thumbnailScreen);
  // }
}

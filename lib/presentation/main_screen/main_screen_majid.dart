// import 'package:conveyor_app/routes/route_name.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// //import 'package:excel/excel.dart';
// import 'dart:io';
// import 'package:open_file/open_file.dart';
// import '../../models/model.dart';
// import '../../controllers/sensor.dart';
// import 'package:conveyor_app/widgets/custom_elevated_button.dart';

// import 'package:conveyor_app/core/app_export.dart';
// import 'package:conveyor_app/widgets/app_bar/appbar_leading_image.dart';
// import 'package:conveyor_app/widgets/app_bar/appbar_title.dart';
// import 'package:conveyor_app/widgets/app_bar/custom_app_bar.dart';

// class MainScreen extends StatefulWidget {
//   @override
//   State<MainScreen> createState() => _HistorySensorState();
// }

// class _HistorySensorState extends State<MainScreen> {
//   final SensorController sensorController = Get.put(SensorController());

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child: Scaffold(
//         appBar: _buildAppBar(context),
//         body: SingleChildScrollView(
//           child: Column(
//             children: [
//               SizedBox(height: 30.v),
//               _buildCounterBaris1(context),
//               SizedBox(height: 30.v),
//               _buildCounterBaris2(context),
//               SizedBox(height: 30.v),
//               _buildCounterBaris3(context),
//               SizedBox(height: 30.v),
//               _buildCounterBaris4(context),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   PreferredSizeWidget _buildAppBar(BuildContext context) {
//     return AppBar(
//       leadingWidth: 44.h,
//       leading: AppbarLeadingImage(
//         imagePath: ImageConstant.imgArrowLeft,
//         margin: EdgeInsets.only(left: 1, top: 23.v, bottom: 22.v),
//         onTap: () {
//           Get.offAllNamed(RouteName.mainScreen);
//         },
//       ),
//       title: Text("Counter Transfer", style: TextStyle(color: Colors.white)),
//         centerTitle: true,  
//       backgroundColor: Colors.teal, // Customize as needed
//     );
//   }

//   Widget _buildCounterBaris1(BuildContext context) {
//           return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 11.h),
//               child:
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 Padding(
//                     padding: EdgeInsets.only(top: 4.v, bottom: 5.v),
//                     child: Text("Total Transfer",
//                         style: TextStyle(color: Colors.black))),
//                 Padding(
//                     padding: EdgeInsets.only(left: 20.h),
//                     child: _buildTotal(context,
//                         //zipcode: datum.kec1.toString(), rpm: "cm/min"
//                         )),
//                 Spacer(),
//                 SizedBox(
//                     width: 250.h,
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 40.v, vertical: 4.v),
//                               child: Text("Material Stuck",
//                                   style: TextStyle(color: Colors.black))),
//                           _buildstat7(context,
//                               //zipcode: datum.kec2.toString(), rpm: "cm/min"
//                               )
//                         ]))
//               ]));
//   }
//   Widget _buildCounterBaris2(BuildContext context) {
//           return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 11.h),
//               child:
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 Padding(
//                     padding: EdgeInsets.only(top: 4.v, bottom: 5.v),
//                     child: Text("Transfer Success",
//                         style: TextStyle(color: Colors.black))),
//                 Padding(
//                     padding: EdgeInsets.only(left: 20.h),
//                     child: _buildstat1(context,
//                         //zipcode: datum.kec1.toString(), rpm: "cm/min"
//                         )),
//                 Spacer(),
//                 SizedBox(
//                     width: 250.h,
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 40.v, vertical: 4.v),
//                               child: Text("Time Transfer is Too Long",
//                                   style: TextStyle(color: Colors.black))),
//                                 _buildstat4(context,
//                               //zipcode: datum.kec2.toString(), rpm: "cm/min"
//                               )
//                         ]))
//               ]));
//   }
//   Widget _buildCounterBaris3(BuildContext context) {
//           return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 11.h),
//               child:
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 Padding(
//                     padding: EdgeInsets.only(top: 4.v, bottom: 5.v),
//                     child: Text("Enter Problem",
//                         style: TextStyle(color: Colors.black))),
//                 Padding(
//                     padding: EdgeInsets.only(left: 20.h),
//                     child: _buildstat2(context,
//                         //zipcode: datum.kec1.toString(), rpm: "cm/min"
//                         )),
//                 Spacer(),
//                 SizedBox(
//                     width: 300.h,
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 40.v, vertical: 4.v),
//                               child: Text("Time Transfer is Too Long: Enter Problem",
//                                   style: TextStyle(color: Colors.black))),
//                           _buildstat5(context,
//                               //zipcode: datum.kec2.toString(), rpm: "cm/min"
//                               )
//                         ]))
//               ]));
//   }
//   Widget _buildCounterBaris4(BuildContext context) {
//           return Padding(
//               padding: EdgeInsets.symmetric(horizontal: 11.h),
//               child:
//                   Row(mainAxisAlignment: MainAxisAlignment.center, children: [
//                 Padding(
//                     padding: EdgeInsets.only(top: 4.v, bottom: 5.v),
//                     child: Text("Material Fall",
//                         style: TextStyle(color: Colors.black))),
//                 Padding(
//                     padding: EdgeInsets.only(left: 20.h),
//                     child: _buildstat3(context,
//                         //zipcode: datum.kec1.toString(), rpm: "cm/min"
//                         )),
//                 Spacer(),
//                 SizedBox(
//                     width: 300.h,
//                     child: Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [
//                           Padding(
//                               padding: EdgeInsets.symmetric(
//                                   horizontal: 40.v, vertical: 4.v),
//                               child: Text("Time Transfer is Too Long: Material Fall",
//                                   style: TextStyle(color: Colors.black))),
//                           _buildstat6(context,
//                               //zipcode: datum.kec2.toString(), rpm: "cm/min"
//                               )
//                         ]))
//               ]));
//   }

//   Widget _buildTotal(BuildContext context) {
//     return StreamBuilder<List<Sensor>>(
//         stream: sensorController.sensorStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: CustomImageView(
//                     imagePath: ImageConstant.imgLoading,
//                     height: 50.v,
//                     width: 50.h,
//                     ),
//             );
//           }
//           int totaltransfer = _getTotalTrasnfer(snapshot.data!);

//           return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: Colors.black,
//           ),
//           color: Colors.white,
//         )
//         //AppDecoration.outlineLightBlue
//         ,
//         child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           Padding(
//               padding: EdgeInsets.symmetric(vertical: 2.v),
//               child: Text('$totaltransfer',
//                   style: CustomTextStyles.bodySmallIstokWebBlack900
//                       .copyWith(color: Colors.black))),
//         ]));});
//   }
//   int _getTotalTrasnfer (List<Sensor> sensors) {
//     int total = 0;
//     for (var sensor in sensors) {
//       total += sensor.data.where(_isTotalTransfer).length;
//     }
//     return total;
//   }

//   static bool _isTotalTransfer(Datum datum) {
//     return datum.stat != null;
//   }

//   Widget _buildstat7(BuildContext context) {
//     return StreamBuilder<List<Sensor>>(
//         stream: sensorController.sensorStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: CustomImageView(
//                     imagePath: ImageConstant.imgLoading,
//                     height: 50.v,
//                     width: 50.h,
//                     ),
//             );
//           }
          
//         int stat7 = _getStat7(snapshot.data!);
//           return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: Colors.black,
//           ),
//           color: Colors.white,
//         )
//         //AppDecoration.outlineLightBlue
//         ,
//         child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           Padding(
//               padding: EdgeInsets.symmetric(vertical: 2.v),
//               child: Text(stat7.toString(),
//                   style: CustomTextStyles.bodySmallIstokWebBlack900
//                       .copyWith(color: Colors.black))),
//         ]));});
//   }
//   int _getStat7 (List<Sensor> sensors) {
//     int total = 0;
//     for (var sensor in sensors) {
//       total += sensor.data.where(_isstat7).length;
//     }
//     return total;
//   }

//   static bool _isstat7(Datum datum) {
//     return datum.stat == 7;
//   }
//   Widget _buildstat1(BuildContext context) {
//     return StreamBuilder<List<Sensor>>(
//         stream: sensorController.sensorStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: CustomImageView(
//                     imagePath: ImageConstant.imgLoading,
//                     height: 50.v,
//                     width: 50.h,
//                     ),
//             );
//           }
          
//           int stat1 = _getStat1(snapshot.data!);

//           return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: Colors.black,
//           ),
//           color: Colors.white,
//         )
//         //AppDecoration.outlineLightBlue
//         ,
//         child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           Padding(
//               padding: EdgeInsets.symmetric(vertical: 2.v),
//               child: Text(stat1.toString(),
//                   style: CustomTextStyles.bodySmallIstokWebBlack900
//                       .copyWith(color: Colors.black))),
//         ]));});
//   }
//   int _getStat1 (List<Sensor> sensors) {
//     int total = 0;
//     for (var sensor in sensors) {
//       total += sensor.data.where(_isstat1).length;
//     }
//     return total;
//   }

//   static bool _isstat1(Datum datum) {
//     return datum.stat == 1;
//   }
//   Widget _buildstat2(BuildContext context) {
//     return StreamBuilder<List<Sensor>>(
//         stream: sensorController.sensorStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: CustomImageView(
//                     imagePath: ImageConstant.imgLoading,
//                     height: 50.v,
//                     width: 50.h,
//                     ),
//             );
//           }
          
//           int stat2 = _getStat2(snapshot.data!);
//           return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: Colors.black,
//           ),
//           color: Colors.white,
//         )
//         //AppDecoration.outlineLightBlue
//         ,
//         child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           Padding(
//               padding: EdgeInsets.symmetric(vertical: 2.v),
//               child: Text(stat2.toString(),
//                   style: CustomTextStyles.bodySmallIstokWebBlack900
//                       .copyWith(color: Colors.black))),
//         ]));});
//   }
//   int _getStat2 (List<Sensor> sensors) {
//     int total = 0;
//     for (var sensor in sensors) {
//       total += sensor.data.where(_isstat2).length;
//     }
//     return total;
//   }

//   static bool _isstat2(Datum datum) {
//     return datum.stat == 2;
//   }
//   Widget _buildstat3(BuildContext context) {
//     return StreamBuilder<List<Sensor>>(
//         stream: sensorController.sensorStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: CustomImageView(
//                     imagePath: ImageConstant.imgLoading,
//                     height: 50.v,
//                     width: 50.h,
//                     ),
//             );
//           }
          
//           int stat3 = _getStat3(snapshot.data!);
//           return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: Colors.black,
//           ),
//           color: Colors.white,
//         )
//         //AppDecoration.outlineLightBlue
//         ,
//         child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           Padding(
//               padding: EdgeInsets.symmetric(vertical: 2.v),
//               child: Text(stat3.toString(),
//                   style: CustomTextStyles.bodySmallIstokWebBlack900
//                       .copyWith(color: Colors.black))),
//         ]));});
//   }
//   int _getStat3 (List<Sensor> sensors) {
//     int total = 0;
//     for (var sensor in sensors) {
//       total += sensor.data.where(_isstat3).length;
//     }
//     return total;
//   }

//   static bool _isstat3(Datum datum) {
//     return datum.stat == 3;
//   }

//   Widget _buildstat4(BuildContext context) {
//     return StreamBuilder<List<Sensor>>(
//         stream: sensorController.sensorStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: CustomImageView(
//                     imagePath: ImageConstant.imgLoading,
//                     height: 50.v,
//                     width: 50.h,
//                     ),
//             );
//           }
          
//           int stat4 = _getStat4(snapshot.data!);
//           return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: Colors.black,
//           ),
//           color: Colors.white,
//         )
//         //AppDecoration.outlineLightBlue
//         ,
//         child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           Padding(
//               padding: EdgeInsets.symmetric(vertical: 2.v),
//               child: Text(stat4.toString(),
//                   style: CustomTextStyles.bodySmallIstokWebBlack900
//                       .copyWith(color: Colors.black))),
//         ]));});
//   }
//   int _getStat4 (List<Sensor> sensors) {
//     int total = 0;
//     for (var sensor in sensors) {
//       total += sensor.data.where(_isstat4).length;
//     }
//     return total;
//   }

//   static bool _isstat4(Datum datum) {
//     return datum.stat == 4;
//   }
//   Widget _buildstat5(BuildContext context) {
//     return StreamBuilder<List<Sensor>>(
//         stream: sensorController.sensorStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: CustomImageView(
//                     imagePath: ImageConstant.imgLoading,
//                     height: 50.v,
//                     width: 50.h,
//                     ),
//             );
//           }
          
//           int stat5 = _getStat5(snapshot.data!);
//           return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: Colors.black,
//           ),
//           color: Colors.white,
//         )
//         //AppDecoration.outlineLightBlue
//         ,
//         child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           Padding(
//               padding: EdgeInsets.symmetric(vertical: 2.v),
//               child: Text(stat5.toString(),
//                   style: CustomTextStyles.bodySmallIstokWebBlack900
//                       .copyWith(color: Colors.black))),
//         ]));});
//   }
//   int _getStat5 (List<Sensor> sensors) {
//     int total = 0;
//     for (var sensor in sensors) {
//       total += sensor.data.where(_isstat5).length;
//     }
//     return total;
//   }

//   static bool _isstat5(Datum datum) {
//     return datum.stat == 5;
//   }
//   Widget _buildstat6(BuildContext context) {
//     return StreamBuilder<List<Sensor>>(
//         stream: sensorController.sensorStream,
//         builder: (context, snapshot) {
//           if (!snapshot.hasData || snapshot.data!.isEmpty) {
//             return Center(
//               child: CustomImageView(
//                     imagePath: ImageConstant.imgLoading,
//                     height: 50.v,
//                     width: 50.h,
//                     ),
//             );
//           }
          
//           int stat6 = _getStat6(snapshot.data!);
//           return Container(
//         padding: EdgeInsets.symmetric(horizontal: 8.h, vertical: 2.v),
//         decoration: BoxDecoration(
//           border: Border.all(
//             width: 1,
//             color: Colors.black,
//           ),
//           color: Colors.white,
//         )
//         //AppDecoration.outlineLightBlue
//         ,
//         child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
//           Padding(
//               padding: EdgeInsets.symmetric(vertical: 2.v),
//               child: Text(stat6.toString(),
//                   style: CustomTextStyles.bodySmallIstokWebBlack900
//                       .copyWith(color: Colors.black))),
//         ]));});
//   }
//   int _getStat6 (List<Sensor> sensors) {
//     int total = 0;
//     for (var sensor in sensors) {
//       total += sensor.data.where(_isstat6).length;
//     }
//     return total;
//   }

//   static bool _isstat6(Datum datum) {
//     return datum.stat == 6;
//   }
// }
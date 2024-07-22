import 'package:conveyor_app/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:conveyor_app/core/app_export.dart';
import 'package:get/get.dart';

class ThumbnailScreen extends StatelessWidget {
  const ThumbnailScreen({Key? key}) : super(key: key);

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
                        EdgeInsets.symmetric(horizontal: 29.h, vertical: 20.v),
                    child: Padding(
                        padding: EdgeInsets.only(right: 18.h),
                        child: Row(children: [
                          CustomImageView(
                              imagePath: ImageConstant.imgGambarConveyor,
                              height: 295.v,
                              width: 328.h),
                          Padding(
                              padding: EdgeInsets.only(
                                  left: 1.h, top: 80.v, bottom: 23.v),
                              child: Column(children: [
                                CustomImageView(
                                    imagePath: ImageConstant.imgPolman1,
                                    height: 100.v,
                                    width: 230.h),
                                SizedBox(height: 14.v),
                                SizedBox(
                                    height: 230.v,
                                    width: 235.h,
                                    child: Stack(
                                        alignment: Alignment.center,
                                        children: [
                                          CustomImageView(
                                              imagePath:
                                                  ImageConstant.imgHttpsLottief,
                                              height: 150.v,
                                              width: 50.h,
                                              alignment: Alignment.bottomCenter,
                                              // margin:
                                              //     EdgeInsets.only(bottom: 1.v),
                                              onTap: () {
                                                  Get.offAllNamed(RouteName.loginScreen);
                                                // onTapImgHttpsLottief(context);
                                              }),
                                          Align(
                                              alignment: Alignment.center,
                                              child: Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 16.h, right: 12.h),
                                                  child: Column(
                                                      mainAxisSize:
                                                          MainAxisSize.min,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Align(
                                                            alignment: Alignment
                                                                .centerRight,
                                                            child: SizedBox(
                                                                width: 210.h,
                                                                child: Text(
                                                                    "Monitoring \nMulticonveyor Inline",
                                                                    maxLines: 2,
                                                                    overflow:
                                                                        TextOverflow
                                                                            .ellipsis,
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                    style: theme
                                                                        .textTheme
                                                                        .titleLarge))),
                                                        SizedBox(height: 18.v),
                                                        Padding(
                                                            padding:
                                                                EdgeInsets.only(
                                                                    left: 75.h),
                                                            child: Text(
                                                                "TAP TO LOG IN",
                                                                style: CustomTextStyles
                                                                    .bodySmallJuraWhiteA700)),
                                                        SizedBox(height: 50),
                                                        Align(
                                                          alignment: Alignment
                                                              .center,
                                                          child: Text(
                                                              "Fauzan Majid | 220441007 | 4AEB-1",
                                                              style: theme
                                                                  .textTheme
                                                                  .bodyMedium)),
                                                        SizedBox(height: 5.v),
                                                        Align(
                                                            alignment: Alignment
                                                                .center,
                                                            child: Text(
                                                                "Tugas Akhir 2024",
                                                                style: theme
                                                                    .textTheme
                                                                    .bodyMedium))
                                                      ])))
                                        ]))
                              ]))
                        ]))))));
  }

  /// Navigates to the loginScreen when the action is triggered.
  onTapImgHttpsLottief(BuildContext context) {
    Get.offAllNamed(RouteName.loginScreen);
    // Navigator.pushNamed(context, AppRoutes.loginScreen);
  }
}

import 'package:flutter/material.dart';
import 'package:conveyor_app/core/app_export.dart';

class AppDecoration {
  // Background decorations
  static BoxDecoration get background => BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(0, 0.5),
          end: Alignment(1, 0.5),
          colors: [
            appTheme.teal400,
            appTheme.teal30001,
            appTheme.teal300,
          ],
        ),
      );

  // Fill decorations
  static BoxDecoration get fillWhiteA => BoxDecoration(
        color: appTheme.whiteA700,
      );

  // Outline decorations
  static BoxDecoration get outlineLightBlue => BoxDecoration(
        color: appTheme.whiteA700,
        border: Border.all(
          color: appTheme.lightBlue700,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineLightblue700 => BoxDecoration(
        color: appTheme.blue200,
        border: Border.all(
          color: appTheme.lightBlue700,
          width: 1.h,
        ),
      );
  static BoxDecoration get outlineLightblue7001 => BoxDecoration(
        border: Border.all(
          color: appTheme.lightBlue700,
          width: 1.h,
        ),
      );
}

class BorderRadiusStyle {}

// Comment/Uncomment the below code based on your Flutter SDK version.

// For Flutter SDK Version 3.7.2 or greater.

double get strokeAlignInside => BorderSide.strokeAlignInside;

double get strokeAlignCenter => BorderSide.strokeAlignCenter;

double get strokeAlignOutside => BorderSide.strokeAlignOutside;

// For Flutter SDK Version 3.7.1 or less.

// StrokeAlign get strokeAlignInside => StrokeAlign.inside;
//
// StrokeAlign get strokeAlignCenter => StrokeAlign.center;
//
// StrokeAlign get strokeAlignOutside => StrokeAlign.outside;

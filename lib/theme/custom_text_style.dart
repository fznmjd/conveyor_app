import 'package:flutter/material.dart';
import '../core/app_export.dart';

/// A collection of pre-defined text styles for customizing text appearance,
/// categorized by different font families and weights.
/// Additionally, this class includes extensions on [TextStyle] to easily apply specific font families to text.

class CustomTextStyles {
  // Body text style
  static get bodySmallInterBlack900 =>
      theme.textTheme.bodySmall!.inter.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallInterWhiteA700 =>
      theme.textTheme.bodySmall!.inter.copyWith(
        color: appTheme.whiteA700,
        fontSize: 10.fSize,
      );
  static get bodySmallIstokWeb => theme.textTheme.bodySmall!.istokWeb;
  static get bodySmallIstokWebBlack900 =>
      theme.textTheme.bodySmall!.istokWeb.copyWith(
        color: appTheme.black900,
      );
  static get bodySmallIstokWebWhiteA700 =>
      theme.textTheme.bodySmall!.istokWeb.copyWith(
        color: appTheme.whiteA700,
      );
  static get bodySmallJuraWhiteA700 => theme.textTheme.bodySmall!.jura.copyWith(
        color: appTheme.whiteA700,
        fontSize: 11.fSize,
      );
  // Title text style
  static get titleLargeBlack900 => theme.textTheme.titleLarge!.copyWith(
        color: appTheme.black900,
      );
}

extension on TextStyle {
  TextStyle get istokWeb {
    return copyWith(
      fontFamily: 'Istok Web',
    );
  }

  TextStyle get inter {
    return copyWith(
      fontFamily: 'Inter',
    );
  }

  TextStyle get jura {
    return copyWith(
      fontFamily: 'Jura',
    );
  }

  // TextStyle get lekton {
  //   return copyWith(
  //     fontFamily: 'Lekton',
  //   );
  // }
}

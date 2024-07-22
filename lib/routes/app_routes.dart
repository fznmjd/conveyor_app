import 'package:conveyor_app/presentation/counter_screen/counter_screen.dart';
import 'package:conveyor_app/presentation/register_screen/register_screen.dart';
import 'package:flutter/material.dart';
import '../presentation/thumbnail_screen/thumbnail_screen.dart';
import '../presentation/login_screen/login_screen.dart';
import '../presentation/main_screen/main_screen.dart';
//import '../presentation/history_screen/history_screen.dart';
import '../presentation/history_screen/history.dart';
import '../presentation/app_navigation_screen/app_navigation_screen.dart';

class AppRoutes {
  static const String thumbnailScreen = '/thumbnail_screen';

  static const String loginScreen = '/login_screen';

  static const String registerScreen = '/register_screen';

  static const String mainScreen = '/main_screen';

  static const String historyScreen = '/history_screen';

  static const String counterScreen = '/counter_screen';

  // static const String history = '/history';

  static const String appNavigationScreen = '/app_navigation_screen';

  static Map<String, WidgetBuilder> routes = {
    thumbnailScreen: (context) => ThumbnailScreen(),
    loginScreen: (context) => LoginScreen(),
    registerScreen: (context) => RegisterScreen(),
    mainScreen: (context) => MainScreen(),
    historyScreen: (context) => HistorySensor(),
    counterScreen: (context) => CounterScreen(),
    // history: (context) => HistorySensor(),
    appNavigationScreen: (context) => AppNavigationScreen()
  };
}

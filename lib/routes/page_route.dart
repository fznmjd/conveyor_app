import 'package:conveyor_app/presentation/add_user_screen/add_user_screen.dart';
import 'package:conveyor_app/presentation/app_navigation_screen/app_navigation_screen.dart';
import 'package:conveyor_app/presentation/counter_screen/counter_screen.dart';
import 'package:conveyor_app/presentation/history_screen/history.dart';
import 'package:conveyor_app/presentation/login_screen/login_screen.dart';
import 'package:conveyor_app/presentation/main_screen/main_screen.dart';
import 'package:conveyor_app/presentation/main_screen/main_screen_operator.dart';
import 'package:conveyor_app/presentation/register_screen/register_screen.dart';
import 'package:conveyor_app/presentation/thumbnail_screen/thumbnail_screen.dart';
import 'package:get/get.dart';
import 'route_name.dart';


class AppPage {
  static final pages = [
    GetPage(
      name: RouteName.thumbnailScreen,
      page: () => ThumbnailScreen(),
    ),
    GetPage(
      name: RouteName.loginScreen,
      page: () => LoginScreen(),
    ),
    GetPage(
      name: RouteName.registerScreen,
      page: () => RegisterScreen(),
    ),
    GetPage(
      name: RouteName.mainScreen,
      page: () => MainScreen(),
    ),
    GetPage(
      name: RouteName.mainScreenOperator,
      page: () => MainScreenOperator(),
    ),
    GetPage(
      name: RouteName.historyScreen,
      page: () => HistorySensor(),
    ),
    GetPage(
      name: RouteName.counterScreen,
      page: () => CounterScreen(),
    ),
    GetPage(
      name: RouteName.appNavigationScreen,
      page: () => AppNavigationScreen(),
    ),
    GetPage(
      name: RouteName.addUser,
      page: () => AddUser(),
    ),
 
  ];
}
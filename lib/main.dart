import 'package:conveyor_app/controllers/sensor.dart';
import 'package:conveyor_app/presentation/add_user_screen/add_user_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:awesome_notifications/awesome_notifications.dart';

import './presentation/thumbnail_screen/thumbnail_screen.dart';
import 'presentation/main_screen/main_screen.dart';
//import 'package:flutter/scheduler.dart';
import 'core/app_export.dart';
import './routes/page_route.dart';
import './services/background_service.dart';

var globalMessengerKey = GlobalKey<ScaffoldMessengerState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeService();
  AwesomeNotifications().initialize(
    'resource://mipmap/ic_launcher',
    [
      NotificationChannel(
        channelKey: 'basic_channel',
        channelName: 'Basic notifications',
        channelDescription: 'Notification channel for basic tests',
        defaultColor: Color(0xFF9D50DD),
        ledColor: Colors.white
      )
    ]
  );
  
   SharedPreferences prefs = await SharedPreferences.getInstance();
  String? accessToken = prefs.getString('accessToken');
  Get.put(SensorController());
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
  ]);

  ///Please update theme as per your need if required.
  ThemeHelper().changeTheme('primary');
  runApp(MyApp(accessToken: accessToken));
}

class MyApp extends StatelessWidget {
    final String? accessToken;
  MyApp({this.accessToken});
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
    print('accessToken: ${accessToken}' );
        return GetMaterialApp(
          theme: theme,
          title: 'fauzan_s_application',
          debugShowCheckedModeBanner: false,
          // home: AddUser(),
          home: accessToken != null ? MainScreen() : ThumbnailScreen() ,
           getPages: AppPage.pages,
          routes: AppRoutes.routes,
        );
      },
    );
  }
}

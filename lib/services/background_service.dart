import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import '../models/model.dart';
import '../controllers/sensor.dart';

SensorController sensorController = SensorController();

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
      autoStart: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
    ),
  );
  service.startService();
}

bool onIosBackground(ServiceInstance service) {
  //WidgetsFlutterBinding.ensureInitialized();
  return true;
}

void onStart(ServiceInstance service) {
  DartPluginRegistrant.ensureInitialized();
  sensorController.onInit(); // Initialize the sensor controller

  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen((event) {
      service.setAsForegroundService();
    });

    service.on('setAsBackground').listen((event) {
      service.setAsBackgroundService();
    });
  }

  Timer.periodic(const Duration(milliseconds: 500), (timer) async {
    Datum? latestDatum = sensorController.latestDatumWithKond;

    if (latestDatum != null) {
      if(latestDatum.kond == 1){
          AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 1,
          channelKey: 'basic_channel',
          title: 'Warning!',
          body: 'Material Stuck',
        ),
      );
      };
      if(latestDatum.ind1 == 1 || latestDatum.ind2 == 1){
          AwesomeNotifications().createNotification(
        content: NotificationContent(
          id: 2,
          channelKey: 'basic_channel',
          title: 'Warning!',
          body: 'Material Fall',
        ),
      );
      };
    }
  });
}

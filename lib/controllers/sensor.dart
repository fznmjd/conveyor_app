import 'dart:async';
import 'dart:convert';

import 'package:get/get.dart';
import '../providers/api.dart';
import '../models/model.dart';


class SensorController extends GetxController {
  final ApiController apiController = ApiController();
  RxList<Sensor> sensors = <Sensor>[].obs;
  Datum? latestDatumWithKond;
  var status = false.obs;

  final _sensorStreamController = StreamController<List<Sensor>>.broadcast();
  final _sensorStreamControllerLast = StreamController<List<Sensor>>.broadcast();
  Stream<List<Sensor>> get sensorStream => _sensorStreamController.stream;
  Stream<List<Sensor>> get sensorStreamLast => _sensorStreamControllerLast.stream;


  @override
  void onInit() {
    super.onInit();
    Timer.periodic(Duration(seconds: 1), (timer) {
      fetchData();
      statusPlant();
      fetchDataLast();
    });
  }
  Future<void> statusPlant() async {
    try {
      final response = await apiController.statusPlant();
      status.value = response;
      print('response: ${status}');
    } catch (e) {
      print('Error fetchData: $e');
    }
  }

  Future<void> fetchData() async {
    try {
      final response = await apiController.fetchData();

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        //print('Response Data Type: ${responseData.runtimeType}');
        print ('Succeed to Get Data');

        if (responseData is List) {
          sensors.assignAll(
            responseData.map((data) => Sensor.fromJson(data)).toList(),
          );
        } else if (responseData is Map<String, dynamic>) {
          final Sensor singleSensor = Sensor.fromJson(responseData);
          sensors.assignAll([singleSensor]);
        } else {
          print('Invalid sensor update type: ${responseData.runtimeType}');
        }

        _sensorStreamController.add(sensors.toList());

      } else {
        throw Exception(
          'Gagal mengambil data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetch: $e');
    }
    print ('End Time: ${DateTime.timestamp()}');
  }

  Future<void> fetchDataLast() async {
    try {
      final response = await apiController.fetchDataLast();

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        //print('Response Data Type: ${responseData.runtimeType}');
        print ('Succeed to Get Data');

        if (responseData is Map<String, dynamic>) {
          final Sensor singleSensor = Sensor.fromJson(responseData);
          sensors.assignAll([singleSensor]);
        } else {
          print('Invalid sensor update type: ${responseData.runtimeType}');
        }

        _sensorStreamControllerLast.add(sensors.toList());
        // Update latestDatumWithKond
        latestDatumWithKond = getLastDatumWithKond();

      } else {
        throw Exception(
          'Gagal mengambil data. Status code: ${response.statusCode}',
        );
      }
    } catch (e) {
      print('Error fetch: $e');
    }
    print ('End Time: ${DateTime.timestamp()}');
  }

  Datum? getLastDatumWithKond() {
    for (var sensor in sensors) {
      for (var datum in sensor.data) {
        if (datum.kond != null) {
          return datum;
        }
      }
    }
    return null;
  }
  @override
  void onClose() {
    _sensorStreamController.close(); // Tutup stream controller
    super.onClose();
  }
}

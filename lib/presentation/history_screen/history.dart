import 'package:conveyor_app/routes/route_name.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:open_file/open_file.dart';
import '../../models/model.dart';
import '../../controllers/sensor.dart';
import 'package:conveyor_app/widgets/custom_elevated_button.dart';

import 'package:conveyor_app/core/app_export.dart';
import 'package:conveyor_app/widgets/app_bar/appbar_leading_image.dart';
import 'package:conveyor_app/widgets/app_bar/appbar_title.dart';
import 'package:conveyor_app/widgets/app_bar/custom_app_bar.dart';

class HistorySensor extends StatefulWidget {
  @override
  State<HistorySensor> createState() => _HistorySensorState();
}

class _HistorySensorState extends State<HistorySensor> {
  final SensorController sensorController = Get.put(SensorController());

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                //height: 400.0, // Adjust the height as needed
                child: SensorDataTable(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
      leadingWidth: 44.h,
      leading: AppbarLeadingImage(
        imagePath: ImageConstant.imgArrowLeft,
        margin: EdgeInsets.only(left: 1, top: 23.v, bottom: 22.v),
        onTap: () {
          Get.offAllNamed(RouteName.mainScreen);
        },
      ),
      title: AppbarTitle(
        text: "TRANSFER HISTORY",
        margin: EdgeInsets.only(left: 5.h),
      ),
      // actions: [
      //   Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: CustomElevatedButton(
      //       margin: EdgeInsets.only(right: 30.h),
      //       height: 25.h,
      //       width: 100.h,
      //       text: "Download and Open",
      //       alignment: Alignment.center,
      //       onPressed: () => _exportToExcel(),
      //     ),
      //   ),
      // ],
      backgroundColor: Colors.teal, // Customize as needed
    );
  }

  Future<void> _exportToExcel() async {
    var sensors = await sensorController.sensorStream.first;
    var excel = Excel.createExcel();
    Sheet sheettotal = excel['Total_Transfer'];
    Sheet sheet1 = excel['Transfer_Success'];
    Sheet sheet2 = excel['Enter_Problem'];
    Sheet sheet3 = excel['Material_Fall'];
    Sheet sheet4 = excel['Too_Long'];
    Sheet sheet5 = excel['Too_Long_Enter_Problem'];
    Sheet sheet6 = excel['Too_Long_Material Fall'];
    Sheet sheet7 = excel['Material Stuck'];
    // Add column headers
    List<TextCellValue> headers = [
      TextCellValue('Date'),
      TextCellValue('Time'),
      TextCellValue('Duration (sekon)'),
      TextCellValue('Conveyor 1 (cm/min)'),
      TextCellValue('Conveyor 2 (cm/min)'),
      TextCellValue('Status'),
    ];
    sheettotal.appendRow(headers);
    sheet1.appendRow(headers);
    sheet2.appendRow(headers);
    sheet3.appendRow(headers);
    sheet4.appendRow(headers);
    sheet5.appendRow(headers);
    sheet6.appendRow(headers);
    sheet7.appendRow(headers);
    // Add data
    for (Sensor sensor in sensors) {
      for (Datum datum in sensor.data) {
        if (_isValidDatum(datum)) {
          sheettotal.appendRow([
            TextCellValue(DateFormat('dd MMMM yyyy').format(datum.waktu.toLocal())),
            TextCellValue(DateFormat('HH:mm:ss').format(datum.waktu.toLocal())),
            TextCellValue(datum.stat == 7 ? "See On The Next Data" : datum.dur.toString()),
            TextCellValue(datum.konv1.toString()),
            TextCellValue(datum.konv2.toString()),
            TextCellValue(datum.stat == 1
                ? "Success"
                : datum.stat == 2
                    ? "Enter Problem"
                    : datum.stat == 3
                        ? "Material Fall"
                        : datum.stat == 4
                            ? "Time Transfer is Too Long"
                            : datum.stat == 5
                                ? "Time Transfer is Too Long: Enter Problem"
                                : datum.stat == 6
                                    ? "Time Transfer is Too Long: Material Fall"
                                    : "Warning"
          )]);
        }
        if (_isStat1(datum)) {
          sheet1.appendRow([
            TextCellValue(DateFormat('dd MMMM yyyy').format(datum.waktu.toLocal())),
            TextCellValue(DateFormat('HH:mm:ss').format(datum.waktu.toLocal())),
            TextCellValue(datum.stat == 7 ? "See On The Next Data" : datum.dur.toString()),
            TextCellValue(datum.konv1.toString()),
            TextCellValue(datum.konv2.toString()),
            TextCellValue("SUCCESS"
          )]);
        }
        if (_isStat2(datum)) {
          sheet2.appendRow([
            TextCellValue(DateFormat('dd MMMM yyyy').format(datum.waktu.toLocal())),
            TextCellValue(DateFormat('HH:mm:ss').format(datum.waktu.toLocal())),
            TextCellValue(datum.stat == 7 ? "See On The Next Data" : datum.dur.toString()),
            TextCellValue(datum.konv1.toString()),
            TextCellValue(datum.konv2.toString()),
            TextCellValue("Enter Problem"
          )]);
        }
        if (_isStat3(datum)) {
          sheet3.appendRow([
            TextCellValue(DateFormat('dd MMMM yyyy').format(datum.waktu.toLocal())),
            TextCellValue(DateFormat('HH:mm:ss').format(datum.waktu.toLocal())),
            TextCellValue(datum.stat == 7 ? "See On The Next Data" : datum.dur.toString()),
            TextCellValue(datum.konv1.toString()),
            TextCellValue(datum.konv2.toString()),
            TextCellValue("Material Fall"
          )]);
        }
        if (_isStat4(datum)) {
          sheet4.appendRow([
            TextCellValue(DateFormat('dd MMMM yyyy').format(datum.waktu.toLocal())),
            TextCellValue(DateFormat('HH:mm:ss').format(datum.waktu.toLocal())),
            TextCellValue(datum.stat == 7 ? "See On The Next Data" : datum.dur.toString()),
            TextCellValue(datum.konv1.toString()),
            TextCellValue(datum.konv2.toString()),
            TextCellValue("Time Transfer is Too Long"
          )]);
        }
        if (_isStat5(datum)) {
          sheet5.appendRow([
            TextCellValue(DateFormat('dd MMMM yyyy').format(datum.waktu.toLocal())),
            TextCellValue(DateFormat('HH:mm:ss').format(datum.waktu.toLocal())),
            TextCellValue(datum.stat == 7 ? "See On The Next Data" : datum.dur.toString()),
            TextCellValue(datum.konv1.toString()),
            TextCellValue(datum.konv2.toString()),
            TextCellValue("Time Transfer is Too Long: Enter Problem"
          )]);
        }
        if (_isStat6(datum)) {
          sheet6.appendRow([
            TextCellValue(DateFormat('dd MMMM yyyy').format(datum.waktu.toLocal())),
            TextCellValue(DateFormat('HH:mm:ss').format(datum.waktu.toLocal())),
            TextCellValue(datum.stat == 7 ? "See On The Next Data" : datum.dur.toString()),
            TextCellValue(datum.konv1.toString()),
            TextCellValue(datum.konv2.toString()),
            TextCellValue("Time Transfer is Too Long: Material Fall"
          )]);
        }
        if (_isStat7(datum)) {
          sheet7.appendRow([
            TextCellValue(DateFormat('dd MMMM yyyy').format(datum.waktu.toLocal())),
            TextCellValue(DateFormat('HH:mm:ss').format(datum.waktu.toLocal())),
            TextCellValue(datum.stat == 7 ? "See On The Next Data" : datum.dur.toString()),
            TextCellValue(datum.konv1.toString()),
            TextCellValue(datum.konv2.toString()),
            TextCellValue("Warning"
          )]);
        }
      }
    }

    // Save the file
    String filePath = '/storage/emulated/0/History Monitoring Multiconveyor.xlsx';
    File(filePath)
      ..createSync(recursive: true)
      ..writeAsBytesSync(excel.save()!);
    OpenFile.open(filePath);
  }

  static bool _isValidDatum(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat != null;
  }
  static bool _isStat1(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 1;
  }
  static bool _isStat2(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 2;
  }
  static bool _isStat3(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 3;
  }
  static bool _isStat4(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 4;
  }
  static bool _isStat5(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 5;
  }
  static bool _isStat6(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 6;
  }
  static bool _isStat7(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 7;
  }
}

class SensorDataTable extends StatelessWidget {
  final SensorController sensorController = Get.find<SensorController>();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Sensor>>(
      stream: sensorController.sensorStream,
      builder: (context, snapshot) {
        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: CircularProgressIndicator(),
          );
        } else {
          return _buildDataTable(snapshot.data!);
        }
      },
    );
  }

  Widget _buildDataTable(List<Sensor> sensorData) {
    return SingleChildScrollView(
      child: PaginatedDataTable(
        columns: [
          DataColumn(
            label: Container(
        width: 50, child: Center(child: Text('Date')),
          )),
          DataColumn(
            label: Container(
        width: 55, child:Center(child: Text('Time')),
          )),
          DataColumn(
            label: Container(
        width: 105, child:Center(child: Text('Duration (sekon)')),
          )),
          DataColumn(
            label: Container(
        width: 135,child: Center(child: Text('Conveyor 1 (cm/min)')),
          )),
          DataColumn(
            label: Container(
        width: 135,child: Center(child: Text('Conveyor 2 (cm/min)')),
          )),
          DataColumn(
            label: Container(
        width: 165, child:Center(child: Text('Status')),
          )),
        ],
        source: SensorDataSource(sensorData),
        rowsPerPage: 7,
      ),
    );
  }
}

class SensorDataSource extends DataTableSource {
  final List<Sensor> sensorData;
  List<Datum> _sortedData;

  SensorDataSource(this.sensorData) : _sortedData = _getFlattenedData(sensorData);

  static List<Datum> _getFlattenedData(List<Sensor> sensors) {
    return sensors.expand((sensor) => sensor.data.where(_isValidDatum)).toList();
  }

  void sort<T>(Comparable<T>? Function(Datum datum) getField, bool ascending) {
    _sortedData.sort((a, b) {
      final aValue = getField(a);
      final bValue = getField(b);

      // Handle null values
      if (aValue == null && bValue == null) return 0;
      if (aValue == null) return ascending ? -1 : 1;
      if (bValue == null) return ascending ? 1 : -1;

      return ascending ? Comparable.compare(aValue, bValue) : Comparable.compare(bValue, aValue);
    });
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    if (index >= _sortedData.length) return null;

    final datum = _sortedData[index];
    final cells = [
      DataCell(Container(
        width: 50, // Set the width you want
        child: Center(child: Text(DateFormat('dd MMMM yyyy').format(datum.waktu.toLocal()), style: TextStyle(color: Colors.black), textAlign: TextAlign.center)),
      )),
      DataCell(Container(
        width: 55, // Set the width you want
        child: Center(child: Text(DateFormat('HH:mm:ss').format(datum.waktu.toLocal()), style: TextStyle(color: Colors.black), textAlign: TextAlign.center)),
      )),
      DataCell(Container(
        width: 105, // Set the width you want
        child: Center(child: Text(datum.stat == 7 ? "See On The Next Data" : datum.dur.toString(), style: TextStyle(color: 
        (datum.dur! > 5 ? Colors.orange : datum.dur! > 10 ? Colors.red : datum.stat == 7 ? Colors.red : Colors.green)
        //Colors.black
        ), textAlign: TextAlign.center)),
      )),
      DataCell(Container(
        width: 135, // Set the width you want
        child: Center(child: Text(datum.konv1.toString(), style: TextStyle(color: 
        (datum.konv1! < 500 ? Colors.orange : Colors.green)
        //Colors.black
        ), textAlign: TextAlign.center)),
      )),
      DataCell(Container(
        width: 135, // Set the width you want
        child: Center(child: Text(datum.konv2.toString(), style: TextStyle(color: 
        (datum.konv2! < 500 ? Colors.orange : Colors.green)
        //Colors.black
        ), textAlign: TextAlign.center)),
      )),
      DataCell(Container(
        width: 165, // Set the width you want
        child: Center(child: Text(
          datum.stat == 1
              ? "Success"
              : datum.stat == 2
                  ? "Enter Problem"
                  : datum.stat == 3
                      ? "Material Fall"
                      : datum.stat == 4
                          ? "Time Transfer is Too Long"
                          : datum.stat == 5
                              ? "Time Transfer is Too Long: Enter Problem"
                              : datum.stat == 6
                                  ? "Time Transfer is Too Long: Material Fall"
                                  : "Warning",
          style: TextStyle(color: 
          (datum.stat == 1 ? Colors.green : datum.stat == 7 ? Colors.red : datum.stat == 2 ? Colors.orangeAccent : datum.stat == 3 ? Colors.orangeAccent : Colors.orange)
          //Colors.black
          ),
          textAlign: TextAlign.center,
        )),
      )),
    ];

    return DataRow(cells: cells);
  }

  static bool _isValidDatum(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat != null;
  }

  @override
  int get rowCount => _sortedData.length;
  @override
  bool get isRowCountApproximate => false;
  @override
  int get selectedRowCount => 0;
}

import 'package:conveyor_app/core/app_export.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/model.dart';
import '../../controllers/sensor.dart';

class CounterScreen extends StatelessWidget {
  final SensorController sensorController = Get.put(SensorController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        leading: IconButton(
          onPressed: () {Get.offAllNamed(AppRoutes.mainScreen);},
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
        ),
        title: Text(
          "Counter Transfer",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            SizedBox(height: 50),
            _cardCounter(),
          ],
        ),
      ),
    );
  }

  Widget _cardCounter() {
    return StreamBuilder<List<Sensor>>(
      stream: sensorController.sensorStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
            child: Text('Tidak ada data'),
          );
        }

        final int totaltransfer = _getTotalTransfer(snapshot.data!);
        final int stat1 = _getStat1(snapshot.data!);
        final int stat2 = _getStat2(snapshot.data!);
        final int stat3 = _getStat3(snapshot.data!);
        final int stat4 = _getStat4(snapshot.data!);
        final int stat5 = _getStat5(snapshot.data!);
        final int stat6 = _getStat6(snapshot.data!);
        final int stat7 = _getStat7(snapshot.data!);
        return Column(

          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardCount(
                  satuan: '$totaltransfer',
                  name: "Total Transfer",
                  color: Colors.blue,
                ),
                CardCount(
                  satuan: '$stat1',
                  name: "Transfer Success",
                  color: Colors.green,
                ),
                CardCount(
                  satuan: '$stat2',
                  name: "Enter Problem",
                  color: Colors.orangeAccent,
                ),
                CardCount(
                  satuan: '$stat3',
                  name: "Material Fall",
                  color: Colors.orangeAccent,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CardCount(
                  satuan: '$stat7',
                  name: "Material Stuck",
                  color: Colors.red,
                ),
                CardCount(
                  satuan: '$stat4',
                  name: "Time Transfer is Too Long",
                  color: Colors.orange,
                ),
                CardCount(
                  satuan: '$stat5',
                  name: "Time Transfer is Too Long: Enter Problem",
                  color: Colors.orange,
                ),
                CardCount(
                  satuan: '$stat6',
                  name: "Time Transfer is Too Long: Material Fall",
                  color: Colors.orange,
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  int _getTotalTransfer (List<Sensor> sensors) {
    int total = 0;
    for (var sensor in sensors) {
      total += sensor.data.where(_isTotalTransfer).length;
    }
    return total;
  }

  static bool _isTotalTransfer(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat != null;
  }
  int _getStat1(List<Sensor> sensors) {
    int total = 0;
    for (var sensor in sensors) {
      total += sensor.data.where(_isStat1).length;
    }
    return total;
  }

  bool _isStat1(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 1;
  }
  int _getStat2(List<Sensor> sensors) {
    int total = 0;
    for (var sensor in sensors) {
      total += sensor.data.where(_isStat2).length;
    }
    return total;
  }

  bool _isStat2(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 2;
  }
  int _getStat3(List<Sensor> sensors) {
    int total = 0;
    for (var sensor in sensors) {
      total += sensor.data.where(_isStat3).length;
    }
    return total;
  }

  bool _isStat3(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 3;
  }
  int _getStat4(List<Sensor> sensors) {
    int total = 0;
    for (var sensor in sensors) {
      total += sensor.data.where(_isStat4).length;
    }
    return total;
  }

  bool _isStat4(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 4;
  }
  int _getStat5(List<Sensor> sensors) {
    int total = 0;
    for (var sensor in sensors) {
      total += sensor.data.where(_isStat5).length;
    }
    return total;
  }

  bool _isStat5(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 5;
  }
  int _getStat6(List<Sensor> sensors) {
    int total = 0;
    for (var sensor in sensors) {
      total += sensor.data.where(_isStat6).length;
    }
    return total;
  }

  bool _isStat6(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 6;
  }
  int _getStat7(List<Sensor> sensors) {
    int total = 0;
    for (var sensor in sensors) {
      total += sensor.data.where(_isStat7).length;
    }
    return total;
  }

  bool _isStat7(Datum datum) {
    return datum.dur != null && datum.konv1 != null && datum.konv2 != null && datum.stat == 7;
  }
}

class CardCount extends StatefulWidget {
  final String satuan;
  final String name;
  final Color color;

  const CardCount({
    Key? key,
    required this.satuan,
    required this.name,
    required this.color,
  }) : super(key: key);

  @override
  State<CardCount> createState() => _CardCountState();
}

class _CardCountState extends State<CardCount> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: 160,
        height: 130,
        decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              widget.name,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              widget.satuan,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

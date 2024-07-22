// To parse this JSON data, do
//
//     final sensor = sensorFromJson(jsonString);

import 'dart:convert';
//import 'dart:ffi';

Sensor sensorFromJson(String str) => Sensor.fromJson(json.decode(str));

String sensorToJson(Sensor data) => json.encode(data.toJson());

class Sensor {
    bool success;
    int statusCode;
    List<Datum> data;

    Sensor({
        required this.success,
        required this.statusCode,
        required this.data,
    });

    factory Sensor.fromJson(Map<String, dynamic> json) => Sensor(
        success: json["success"],
        statusCode: json["statusCode"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "success": success,
        "statusCode": statusCode,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    int? ind1;
    int? ind2;
    num? kec1;
    num? kec2;
    int? kond;
    int? dur;
    num? konv1;
    num? konv2;
    int? stat;
    int? table;
    int? startA;
    int? startB;
    DateTime waktu;
    int? v;

    Datum({
        required this.id,
        required this.ind1,
        required this.ind2,
        required this.kec1,
        required this.kec2,
        required this.kond,
        required this.dur,
        required this.konv1,
        required this.konv2,
        required this.stat,
        required this.table,
        required this.startA,
        required this.startB,
        required this.waktu,
        required this.v,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        
        id: json["_id"],
        ind1: json["ind1"],
        ind2: json["ind2"],
        kec1: json["kec1"],
        kec2: json["kec2"],
        kond: json["kond"],
        dur: json["dur"],
        konv1: json["konv1"],
        konv2: json["konv2"],
        stat: json["stat"],
        table: json["table"],
        startA: json["startA"],
        startB: json["startB"],
        waktu: DateTime.parse(json["waktu"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "ind1": ind1,
        "ind2": ind2,
        "kec1": kec1,
        "kec2": kec2,
        "kond": kond,
        "dur": dur,
        "konv1": konv1,
        "konv2": konv2,
        "stat": stat,
        "table": table,
        "startA": startA,
        "startB": startB,
        "waktu": waktu.toIso8601String(),
        "__v": v,
    };
}

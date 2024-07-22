import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ApiController {
  //static const String URL_API = "https://bsg124ff-5000.asse.devtunnels.ms";
  static const String URL_API = "https://api-konveyor-gwuo7fgaxq-uc.a.run.app";

  Future<http.Response> fetchData() async {
    print ('Start Time: ${DateTime.timestamp()}');
    try {
      final response = await http.get(Uri.parse('$URL_API/api/sensors'));
      //print('Status Code: ${response.statusCode}');
      // print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during fetchData: $e');
      throw e;
    }
  }
  Future<http.Response> fetchDataLast() async {
    print ('Start Time: ${DateTime.timestamp()}');
    try {
      final response = await http.get(Uri.parse('$URL_API/api/sensor'));
      print('Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        return response;
      } else {
        throw Exception(
            'Failed to fetch data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error during fetchData: $e');
      throw e;
    }
  }

  Future<http.Response> login (Map<String, dynamic> data ) async {
    try {
      final response = await http.post(Uri.parse('$URL_API/user/login'),
        headers: {
          'Content-Type' : 'application/json',
        },
        body : jsonEncode(data));

        return response;
    } catch (e) {
      throw e;
    }
  }

  Future<http.Response> register (Map<String, dynamic> data ) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    String? getToken = shared.getString("accessToken");
    try {
      final response = await http.post(Uri.parse('$URL_API/user/register'),
        headers: {
          'Content-Type' : 'application/json',
          'Authorization' : 'Bearer $getToken'
        },
        body : jsonEncode(data));

        return response;
    } catch (e) {
      throw e;
    }
  }
  Future statusPlant() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    String? getToken = shared.getString("accessToken");
    Uri url = Uri.parse("$URL_API/kondisiPlant");
    var response = await http.get(url, headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $getToken',
    });
    var data = jsonDecode(response.body) as Map<String, dynamic>;
    bool status = data['status'];
    return status;
  }
}

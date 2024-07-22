import 'dart:convert';

import 'package:conveyor_app/routes/route_name.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:cool_alert/cool_alert.dart';
// import 'package:awesome_dialog/awesome_dialog.dart';
import '../providers/api.dart';
import '../routes/app_routes.dart';

class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var showPassword = false.obs;

  final ApiController apiController = ApiController();

  Future<void> loginWithEmail() async {
    try {
      Map<String, dynamic> body = {
        'username': emailController.text,
        'password': passwordController.text,
      };
      final response = await apiController.login(body);
      final jsonResponse = jsonDecode(response.body);
      if (response.statusCode == 200) {
        if (jsonResponse['success'] == true) {
          final userData = jsonResponse['data'];
          final accessToken = userData['accessToken'];
          final userName = userData['userName'];
          final role = userData['role'];
          SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString('accessToken', accessToken);
          await prefs.setString('userName', userName);
          await prefs.setString('role', role);
          print('username: ${userName}');
          print('role: ${role}');

          emailController.clear();
          passwordController.clear();
          if (role == "admin"){
          Get.offAllNamed(RouteName.mainScreen);
          _success(jsonResponse);
          }
          if (role == "supervisor"){
          Get.offAllNamed(RouteName.mainScreen);
          _success(jsonResponse);
          }
          if (role == "operator"){
          Get.offAllNamed(RouteName.mainScreenOperator);
          _success(jsonResponse);
          }

        } else {
          throw (jsonResponse['message'] ?? "Login failed");
        }
      } else {
        throw (jsonResponse['message']);
      }
    } catch (e) {
      Get.back();
      Get.snackbar(
        'Failed',
        e.toString(),
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void _success(jsonResponse) {
    Get.snackbar(
      'Success',
      jsonResponse['message'],
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
  }

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }
}
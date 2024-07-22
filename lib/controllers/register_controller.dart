// controllers/register_controller.dart
import 'dart:convert';

import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../providers/api.dart';
import '../routes/app_routes.dart';

class RegisterController extends GetxController {
  TextEditingController nameController = TextEditingController();
  TextEditingController roleController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var showPassword = false.obs;

  final ApiController apiController = ApiController();

  Future<void> registerWithEmail() async {
    try {
      Map<String, dynamic> body = {
        'username': nameController.text,
        'role': roleController.text,
        'password': passwordController.text,
      };

      final response = await apiController.register(body);
      print("ada: ${response}");
      if (response == null) {
        throw ("Response is null");
      }

      final jsonResponse = jsonDecode(response.body);
      print("code ${response.statusCode}");
      if (response.statusCode == 200) {
        if (jsonResponse['success'] == true) {
          nameController.clear();
          roleController.clear();
          passwordController.clear();
          Get.snackbar(
            'Success',
            jsonResponse['message'] ?? 'Registration successful',
            snackPosition: SnackPosition.TOP,
            backgroundColor: Colors.green,
            colorText: Colors.white,
          );
          // Get.offAllNamed(AppRoutes.loginScreen);
        } else {
          throw (jsonResponse['message'] ?? "Registration failed");
        }
      } else {
        throw (jsonResponse['message'] ?? "An error occurred");
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

  void toggleShowPassword() {
    showPassword.value = !showPassword.value;
  }
}

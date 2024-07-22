// user_controller.dart
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';


class UserController extends GetxController {
  static String authToken = '';
  var username = ''.obs;
  var role = ''.obs;

  Future<bool> checkLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? accessToken = prefs.getString('accessToken');
    if (accessToken != null) {
      String username = prefs.getString('userName') ?? 'Anonymous';
      String role = prefs.getString('role') ?? 'Anonymous';
      setRole(role);
      setUsername(username);
      print("username: ${username}");
      return true;
    } else {
      return false;
    }
  }

  setRole(String roleN) {
    role.value = roleN;
  }

  setUsername(String name) {
    username.value = name;
  }

  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('accessToken');
    await prefs.remove('userName');
    setUsername('');
    await prefs.remove('accessToken');
    authToken = '';
  }
}
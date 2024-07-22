import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:conveyor_app/core/app_export.dart';
import 'package:conveyor_app/widgets/custom_elevated_button.dart';
import 'package:conveyor_app/widgets/custom_text_form_field.dart';
import '../../controllers/register_controller.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:conveyor_app/providers/api.dart';

class AddUser extends StatefulWidget {
  @override
  State<AddUser> createState() => _AddUserState();
}

class _AddUserState extends State<AddUser> {
  late StreamController<List<Map<String, dynamic>>> _streamController;
  int _currentPage = 0;
  final int _itemsPerPage = 3;
  String? selectedRole;
  final List<String> roles = ['admin', 'operator', 'supervisor'];
  final TextEditingController roleController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _streamController = StreamController<List<Map<String, dynamic>>>();
    fetchAllImages();
  }

  Future<void> fetchAllImages() async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    String? getToken = shared.getString("accessToken");
    try {
      final response = await http.get(
        Uri.parse('https://api-konveyor-gwuo7fgaxq-uc.a.run.app/user/all'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $getToken'
        },
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body)['data'];
        if (responseData != null && responseData is List) {
          List<Map<String, dynamic>> userList =
              responseData.cast<Map<String, dynamic>>().toList();
          // Sort the list based on role priority
          userList.sort((a, b) {
            List<String> roleOrder = ['admin', 'supervisor', 'operator'];
            return roleOrder.indexOf(a['role']).compareTo(roleOrder.indexOf(b['role']));
          });
          _streamController.add(userList);
        } else {
          _streamController.add([]); // Return empty list if responseData is null or not a list
        }
      } else {
        final errorMessage =
            json.decode(response.body)['message'] ?? 'Unknown error';
        throw (errorMessage);
      }
    } catch (e) {
      _streamController.addError('Error fetching data: $e');
    }
  }

  Future<void> _deleteImage(String id) async {
    final SharedPreferences shared = await SharedPreferences.getInstance();
    String? getToken = shared.getString("accessToken");
    try {
      final response = await http.delete(
        Uri.parse('https://api-konveyor-gwuo7fgaxq-uc.a.run.app/user/delete/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $getToken'
        },
      );
      if (response.statusCode == 200) {
        // Image successfully deleted, refresh data
        fetchAllImages();
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Terhapus'),
              content: Text('User berhasil dihapus.', style: TextStyle(color: Colors.black)),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ],
            );
          },
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Gagal'),
              content: Text('Gagal menghapus gambar.'),
              actions: <Widget>[
                TextButton(
                  child: Text('OK'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    Get.back();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (error) {
      print('Error deleting image: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting image')),
      );
    }
  }

  List<Map<String, dynamic>> _getCurrentPageData(List<Map<String, dynamic>> allImages) {
    final int startIndex = _currentPage * _itemsPerPage;
    int endIndex = startIndex + _itemsPerPage;
    if (endIndex > allImages.length) {
      endIndex = allImages.length;
    }
    return allImages.sublist(startIndex, endIndex);
  }

  void _nextPage() {
    setState(() {
      _currentPage++;
    });
  }

  void _previousPage() {
    setState(() {
      _currentPage--;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RegisterController _registerController = Get.put(RegisterController());
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue.shade600,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle the back button press
            Get.offAllNamed(AppRoutes.mainScreen);
          },
        ),
        title: Text("Management User", style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Text("Add User",
                            style: CustomTextStyles.titleLargeBlack900),
                        SizedBox(width: 100, child: Divider()),
                        SizedBox(height: 13),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Role",
                              style: CustomTextStyles.bodySmallIstokWebBlack900),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: DropdownButtonFormField2(
                            decoration: InputDecoration(
                              isDense: true,
                              contentPadding: EdgeInsets.all(20),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            isExpanded: true,
                            hint: Text(
                              'Pilih Role',
                              style: TextStyle(fontSize: 14, color: Colors.black),
                            ),
                            items: roles
                                .map((item) => DropdownMenuItem<String>(
                                      value: item,
                                      child: Text(
                                        item,
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ))
                                .toList(),
                            validator: (value) {
                              if (value == null) {
                                return 'Silakan pilih role.';
                              }
                              return null;
                            },
                            onChanged: (value) {
                              setState(() {
                                selectedRole = value as String?;
                                _registerController.roleController.text =
                                    selectedRole!;
                              });
                            },
                            onSaved: (value) {
                              selectedRole = value.toString();
                              _registerController.roleController.text =
                                  selectedRole!;
                            },
                          ),
                        ),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Username",
                              style: CustomTextStyles.bodySmallIstokWebBlack900),
                        ),
                        CustomTextFormField(
                            width: 260.h,
                            controller: _registerController.nameController),
                        SizedBox(height: 18.v),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Text("Password",
                              style: CustomTextStyles.bodySmallIstokWebBlack900),
                        ),
                        CustomTextFormField(
                          width: 260.h,
                          controller: _registerController.passwordController,
                          textInputAction: TextInputAction.done,
                        ),
                        SizedBox(height: 32.v),
                        CustomElevatedButton(
                          height: 30.v,
                          width: 130.h,
                          text: "ADD USER",
                          buttonStyle: CustomButtonStyles.fillLightBlue,
                          onPressed: () async {
                            _registerController.registerWithEmail();
                            await Future.delayed(Duration(seconds: 1));
                            fetchAllImages(); // Refresh the data after adding a user
                          },
                        ),
                        SizedBox(height: 3.v),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        SizedBox(height: 60),
                        Text("Data User",
                            style: CustomTextStyles.titleLargeBlack900),
                        SizedBox(width: 100, child: Divider()),
                        SizedBox(height: 13),
                        StreamBuilder<List<Map<String, dynamic>>>(
                          stream: _streamController.stream,
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else if (!snapshot.hasData ||
                                snapshot.data!.isEmpty) {
                              return Text('No data available');
                            } else {
                              return Column(
                                children: [
                                  ListView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        _getCurrentPageData(snapshot.data!).length,
                                    itemBuilder: (context, index) {
                                      final user =
                                          _getCurrentPageData(snapshot.data!)[index];
                                      final id = user['id'];
                                      return Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadiusDirectional.circular(20),
                                            color: user['role'] == "admin"
                                                ? Colors.blue
                                                : user['role'] == "supervisor"
                                                    ? Colors.blue.shade300
                                                    : Colors.blue.shade100,
                                          ),
                                          child: ListTile(
                                            title: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(user['username'] ??
                                                    'No Name'),
                                                if (user['username'] != "admin")
                                                  IconButton(
                                                    onPressed: () {
                                                      showDialog(
                                                        context: context,
                                                        builder:
                                                            (BuildContext context) {
                                                          return AlertDialog(
                                                            title: Text('Informasi'),
                                                            content: Text(
                                                                'Apakah anda yakin untuk menghapusnya?', style: TextStyle(color: Colors.black),),
                                                            actions: <Widget>[
                                                              TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child: Text('Tidak'),
                                                              ),
                                                              TextButton(
                                                                onPressed: () async {
                                                                  Get.back();
                                                                  await _deleteImage(
                                                                      id);
                                                                },
                                                                child: Text('Iya'),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    },
                                                    icon: Icon(Icons.delete),
                                                    color: Colors.red,
                                                  ),
                                              ],
                                            ),
                                            subtitle: Text(user['role'] ??
                                                'No Role'),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      IconButton(
                                        onPressed:
                                            _currentPage > 0 ? _previousPage : null,
                                        icon: Icon(Icons.arrow_back),
                                      ),
                                      Text('Page ${_currentPage + 1}'),
                                      IconButton(
                                        onPressed: _currentPage <
                                                (snapshot.data!.length /
                                                        _itemsPerPage)
                                                    .ceil() -
                                            1
                                            ? _nextPage
                                            : null,
                                        icon: Icon(Icons.arrow_forward),
                                      ),
                                    ],
                                  ),
                                ],
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

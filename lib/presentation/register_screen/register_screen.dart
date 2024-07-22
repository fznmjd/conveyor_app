//import 'dart:ffi';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:conveyor_app/core/app_export.dart';
import 'package:conveyor_app/widgets/custom_elevated_button.dart';
import 'package:conveyor_app/widgets/custom_text_form_field.dart';
import '../../controllers/register_controller.dart';



// ignore_for_file: must_be_immutable
class RegisterScreen extends StatelessWidget {
  final RegisterController _registerController = Get.put(RegisterController());
  RegisterScreen({Key? key}) : super(key: key);

  TextEditingController userNameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  String Username = "";
  String Password = "";

  
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            extendBodyBehindAppBar: true,
            resizeToAvoidBottomInset: false,
            body: Container(
                width: SizeUtils.width,
                height: SizeUtils.height,
                decoration: BoxDecoration(
                    gradient: LinearGradient(
                        begin: Alignment(0, 0.5),
                        end: Alignment(1, 0.5),
                        colors: [
                      appTheme.teal400,
                      appTheme.teal30001,
                      appTheme.teal300
                    ])),
                child: Container(
                    width: double.maxFinite,
                    padding: EdgeInsets.symmetric(vertical: 60.v),
                    child: Column(children: [
                      SizedBox(height: 10.v),
                      _buildLoginForm(context)
                    ])))));
  }

  /// Section Widget
  Widget _buildLoginForm(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(left: 150.h, right: 150.h),
        padding: EdgeInsets.symmetric(horizontal: 44.h, vertical: 16.v),
        decoration: AppDecoration.outlineLightBlue,
        child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("REGISTER", style: CustomTextStyles.titleLargeBlack900),
              // SizedBox(height: 4.v),
              SizedBox(width: 100.h, child: Divider()),
              SizedBox(height: 13.v),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Email",
                      style: CustomTextStyles.bodySmallIstokWebBlack900)),
              
              CustomTextFormField(width: 260.h, controller: _registerController.roleController),
              SizedBox(height: 18.v),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Username",
                      style: CustomTextStyles.bodySmallIstokWebBlack900)),
              
              CustomTextFormField(width: 260.h, controller: _registerController.nameController ),
              SizedBox(height: 18.v),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Password",
                      style: CustomTextStyles.bodySmallIstokWebBlack900)),
              
              CustomTextFormField(
                  width: 260.h,
                  controller: _registerController.passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true),
              SizedBox(height: 32.v),
              CustomElevatedButton(
                  height: 30.v,
                  width: 130.h,
                  text: "REGISTER",
                  buttonStyle: CustomButtonStyles.fillLightBlue,
                  onPressed: () {
                
                    _registerController.registerWithEmail();
                  }),
              SizedBox(height: 3.v)
            ]));
  }

  /// Navigates to the mainScreen when the action is triggered.
  // onTapLOGIN(BuildContext context) {
  //   if (Username == "tugasakhir") {
  //     if (Password == "majid") {
  //       Navigator.pushNamed(context, AppRoutes.mainScreen);
  //     }
  //   }
        
      
    
  // }
}

//import 'dart:ffi';
import 'package:conveyor_app/routes/route_name.dart';
import 'package:get/get.dart';

import 'package:flutter/material.dart';
import 'package:conveyor_app/core/app_export.dart';
import 'package:conveyor_app/widgets/custom_elevated_button.dart';
import 'package:conveyor_app/widgets/custom_text_form_field.dart';
import '../../controllers/login_controller.dart';



// ignore_for_file: must_be_immutable
class LoginScreen extends StatelessWidget {
  final LoginController _loginController = Get.put(LoginController());
  LoginScreen({Key? key}) : super(key: key);

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
                    padding: EdgeInsets.symmetric(vertical: 70.v),
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
              Text("LOGIN", style: CustomTextStyles.titleLargeBlack900),
              SizedBox(height: 4.v),
              SizedBox(width: 100.h, child: Divider()),
              SizedBox(height: 13.v),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Username",
                      style: CustomTextStyles.bodySmallIstokWebBlack900)),
              SizedBox(height: 7.v),
              CustomTextFormField(width: 260.h, controller: _loginController.emailController ),
              SizedBox(height: 22.v),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Password",
                      style: CustomTextStyles.bodySmallIstokWebBlack900)),
              SizedBox(height: 7.v),
              CustomTextFormField(
                  width: 260.h,
                  controller: _loginController.passwordController,
                  textInputAction: TextInputAction.done,
                  obscureText: true),
              SizedBox(height: 32.v),
              CustomElevatedButton(
                  height: 30.v,
                  width: 130.h,
                  text: "LOGIN",
                  buttonStyle: CustomButtonStyles.fillLightBlue,
                  onPressed: () {
                  //    Username = userNameController.text;
                  //    Password = passwordController.text;
                  //  onTapLOGIN(context);
                    _loginController.loginWithEmail();
                  }),
              // SizedBox(height: 15.v),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     Text("Tidak Punya akun?", style: TextStyle(color: Colors.black,),),
              //     SizedBox(width: 20,),
              //       CustomElevatedButton(
              //     height: 25.v,
              //     width: 50.h,
              //     text: "Register",
              //     buttonStyle: CustomButtonStyles.fillLightBlue,
              //     onPressed: () {
              //      Get.offAllNamed(RouteName.registerScreen);
              //     }),
                
              //   ],
              // ),
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

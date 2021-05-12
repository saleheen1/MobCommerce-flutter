import 'package:flutter/material.dart';
import 'package:mobile_seller/screens/register.dart';
import 'package:mobile_seller/widgets/constants.dart';
import 'package:mobile_seller/widgets/customBtn.dart';
import 'package:mobile_seller/widgets/customInput.dart';
import 'package:get/get.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Center(
            child: Container(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 90),
                  child: Text(
                    "Login",
                    style: Constants.bigHeading,
                  ),
                ),
                Column(
                  children: [
                    CustomInput(
                      hintText: "Name",
                    ),
                    CustomInput(
                      hintText: "Email",
                    ),
                    CustomButton(
                      text: "Login",
                      onPressed: () {
                        print("button clicked");
                      },
                      outlineBtn: false,
                    ),
                  ],
                ),
                CustomButton(
                  text: "Create new account",
                  onPressed: () {
                    Get.to(RegisterPage());
                  },
                ),
              ],
            )),
          ),
        ),
      ),
    );
  }
}

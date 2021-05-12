import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/constants.dart';
import 'package:mobile_seller/widgets/customBtn.dart';
import 'package:mobile_seller/widgets/customInput.dart';
import 'package:get/get.dart';

class RegisterPage extends StatelessWidget {
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
                child: Text("Register", style: Constants.bigHeading),
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
                    text: "Register",
                    onPressed: () {
                      print("button clicked");
                    },
                    outlineBtn: false,
                  ),
                ],
              ),
              CustomButton(
                text: "Back to login",
                onPressed: () {
                  Get.back();
                },
              ),
            ],
          )),
        ),
      ),
    ));
  }
}

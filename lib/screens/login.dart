import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/constants.dart';
import 'package:mobile_seller/widgets/customBtn.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
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
              Text(
                "Inputs",
                style: Constants.regularHeading,
              ),
              CustomButton(
                text: "Create new account",
                onPressed: () {
                  print("button clicked");
                },
              ),
            ],
          )),
        ),
      ),
    );
  }
}

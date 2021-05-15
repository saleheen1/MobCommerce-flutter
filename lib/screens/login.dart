import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  bool loadingForm = false;
  //when user writes email and presses enter then we want to move the focus to password automatically
//that's why we need focusnode
  FocusNode _passFocusNode;

  @override
  void initState() {
    _passFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passFocusNode.dispose();
    super.dispose();
  }

  String _userEmail = "";
  String _userPass = "";

  Future<String> _loginToAccount() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _userEmail, password: _userPass);
      //if user already has an account then null will be returned
      return null;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return "weak password";
      } else if (e.code == 'email-already-in-use') {
        return "account already exists";
      } else {
        return e.message;
      }
    } catch (e) {
      return (e.toString());
    }
  }

  void _submitForm() async {
    setState(() {
      loadingForm = true;
    });
    String _loginFeedback = await _loginToAccount();
    if (_loginFeedback != null) {
      //if it's not null then we have some error
      _formErrorToast(_loginFeedback, Colors.red);
      setState(() {
        loadingForm = false;
      });
    } else {
      //else account created successfully
      _formErrorToast("Successfully Logged in!", Colors.green);
    }
  }

  void _formErrorToast(String message, Color _color) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 1,
        backgroundColor: _color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

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
                      hintText: "Email",
                      onChanged: (value) {
                        _userEmail = value;
                      },
                      onSubmitted: (value) {
                        //when pressed enter change focus to password
                        _passFocusNode.requestFocus();
                      },
                      textInputAction: TextInputAction.next,
                    ),
                    CustomInput(
                      hintText: "Password",
                      onChanged: (value) {
                        _userPass = value;
                      },
                      focusNode: _passFocusNode,
                      isPasswordField: true,
                    ),
                    CustomButton(
                      text: "Login",
                      onPressed: () {
                        _submitForm();
                      },
                      outlineBtn: false,
                      isloading: loadingForm,
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

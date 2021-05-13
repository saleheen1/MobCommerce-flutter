import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/constants.dart';
import 'package:mobile_seller/widgets/customBtn.dart';
import 'package:mobile_seller/widgets/customInput.dart';
import 'package:get/get.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool loadingForm = false;

  //form input field values
  String _registerEmail = "";
  String _registerPass = "";

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

  Future<String> _createAccount() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail, password: _registerPass);
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

  void _submitForm() async {
    setState(() {
      loadingForm = true;
    });
    String _createAccountFeedback = await _createAccount();
    if (_createAccountFeedback != null) {
      //if it's not null then we have some error
      _formErrorToast(_createAccountFeedback, Colors.red);
      setState(() {
        loadingForm = false;
      });
    } else {
      //else account created successfully
      _formErrorToast("Account created successfully!", Colors.green);
      Get.back();
    }
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
                child: Text("Register", style: Constants.bigHeading),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: "Email",
                    onChanged: (value) {
                      _registerEmail = value;
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
                      _registerPass = value;
                    },
                    focusNode: _passFocusNode,
                    isPasswordField: true,
                  ),
                  CustomButton(
                    text: "Register",
                    onPressed: () {
                      _submitForm();
                    },
                    outlineBtn: false,
                    isloading: loadingForm,
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

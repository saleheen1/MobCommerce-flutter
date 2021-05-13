import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/constants.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Scaffold(
        body: Center(
          child: InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Container(
              child: Text(
                "Log out",
                style: Constants.regularHeading,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

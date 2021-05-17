import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/actionBar.dart';
import 'package:mobile_seller/widgets/constants.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ActionBar(
          title: "Profile",
        ),
        Center(
          child: InkWell(
            onTap: () {
              FirebaseAuth.instance.signOut();
            },
            child: Container(
              height: 50,
              width: 130,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(horizontal: 18, vertical: 14),
              color: Constants.kPrimary,
              child: Text(
                "Log out",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

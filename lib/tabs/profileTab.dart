import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/actionBar.dart';

class ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ActionBar(
          title: "Profile",
        ),
        Center(
          child: Container(
            child: Text("Profile"),
          ),
        ),
      ],
    );
  }
}

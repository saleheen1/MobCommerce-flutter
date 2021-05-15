import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/actionBar.dart';

class HomeTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ActionBar(
          title: "Home",
        ),
        Center(
          child: Container(
            child: Text("home"),
          ),
        ),
      ],
    );
  }
}

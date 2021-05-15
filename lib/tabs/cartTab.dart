import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/actionBar.dart';

class CartTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ActionBar(
          title: "Cart",
        ),
        Center(
          child: Container(
            child: Text("Cart"),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;

  const CustomInput({Key key, this.hintText}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 19),
        decoration: BoxDecoration(
            color: Color(0xfff2f2f2), borderRadius: BorderRadius.circular(6)),
        child: TextField(
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText ?? "text",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 13, vertical: 13)),
        ));
  }
}

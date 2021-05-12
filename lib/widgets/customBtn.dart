import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;

  const CustomButton({Key key, this.text, this.onPressed, this.outlineBtn})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
        margin: EdgeInsets.only(bottom: 50),
        decoration: BoxDecoration(
            border: Border.all(
              color: Constants.kPrimary,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(6)),
        child: Text(text ?? "Text"),
      ),
    );
  }
}

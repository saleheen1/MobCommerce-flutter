import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;

  const CustomButton(
      {Key key, this.text, this.onPressed, this.outlineBtn = true})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            alignment: Alignment.center,
            width: double.infinity,
            padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            decoration: BoxDecoration(
                color: outlineBtn ? Colors.transparent : Constants.kPrimary,
                border: Border.all(
                  color: Constants.kPrimary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6)),
            child: Text(
              text ?? "Text",
              style: TextStyle(
                  color: outlineBtn ? Constants.kPrimary : Colors.white),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        )
      ],
    );
  }
}

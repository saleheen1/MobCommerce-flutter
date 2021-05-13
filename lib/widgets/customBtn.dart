import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/constants.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isloading;

  const CustomButton(
      {Key key,
      this.text,
      this.onPressed,
      this.outlineBtn = true,
      this.isloading = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onPressed,
          child: Container(
            width: double.infinity,
            height: 50,
            // padding: EdgeInsets.symmetric(horizontal: 60, vertical: 10),
            decoration: BoxDecoration(
                color: outlineBtn ? Colors.transparent : Constants.kPrimary,
                border: Border.all(
                  color: Constants.kPrimary,
                  width: 1,
                ),
                borderRadius: BorderRadius.circular(6)),
            child: Stack(
              children: [
                Visibility(
                  visible: isloading ? false : true,
                  child: Center(
                    child: Text(
                      text ?? "Text",
                      style: TextStyle(
                          color:
                              outlineBtn ? Constants.kPrimary : Colors.white),
                    ),
                  ),
                ),
                Visibility(
                  visible: isloading ? true : false,
                  child: Center(
                      child: SizedBox(
                          height: 36, child: CircularProgressIndicator())),
                )
              ],
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

import 'package:flutter/material.dart';
import 'package:mobile_seller/widgets/constants.dart';

class CustomInput extends StatelessWidget {
  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final TextInputAction textInputAction;
  final bool isPasswordField;

  //when user writes email and presses enter then we want to move the focus to password automatically
//that's why we need focusnode
  final FocusNode focusNode;

  const CustomInput(
      {Key key,
      this.hintText,
      this.onChanged,
      this.onSubmitted,
      this.focusNode,
      this.textInputAction,
      this.isPasswordField = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
        margin: EdgeInsets.only(bottom: 19),
        decoration: BoxDecoration(
            color: Color(0xfff2f2f2), borderRadius: BorderRadius.circular(6)),
        child: TextField(
          focusNode: focusNode,
          onChanged: onChanged,
          onSubmitted: onSubmitted,
          textInputAction: textInputAction,
          obscureText: isPasswordField,
          style: TextStyle(fontSize: 14),
          decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText ?? "text",
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 13, vertical: 13)),
        ));
  }
}

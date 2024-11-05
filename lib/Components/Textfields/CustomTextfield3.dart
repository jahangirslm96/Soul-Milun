import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class CustomTextfield3 extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;

  const CustomTextfield3({
    super.key,
    required this.controller,
    required this.label,
    this.inputType = TextInputType.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Get.height * 0.02),
      child: TextFormField(
        cursorColor: ThemeColors().labelTextColor,
        controller: controller,
        keyboardType: inputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is required';
          } else if (label == "Name" && value.length < 3) {
            return '$label should be at least 3 characters';
          }else if(label == "Name" && value.length >= 20) {
            return '$label should be less than 20 characters';
          }else if (label == "Name" && !GetUtils.isAlphabetOnly(value) && !value.contains(" ")) {
            return '$label should contain only alphabets';
          } else if (label == "Email" && !GetUtils.isEmail(value)) {
            return 'Enter a valid $label';
          }
          return null;
        },
        style: TextStyle(
          color: ThemeColors().onBoardingHeadingColor,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColors().enabledBorderColor,
            ),
          ),
          errorStyle: TextStyle(
            height: 0,
            color: CustomTheme().errorColor,
          ),
          errorBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: CustomTheme().errorColor,
              width: CustomTheme().errorBorderWidth,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              width: 2,
              color: ThemeColors().labelTextColor,
            ),
          ),
          contentPadding: EdgeInsets.all(CustomTheme().paddingInput),
          /*labelStyle: TextStyle(
            color: ThemeColors().labelTextColor,
          ),*/
          hintStyle: TextStyle(
            color: ThemeColors().buttonColor,
          ),
          /*labelText: label,*/
          hintText: label,
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class CustomPasswordTextfield2 extends StatefulWidget {
  bool isHidden;
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;

  CustomPasswordTextfield2({
    super.key,
    required this.controller,
    required this.label,
    this.isHidden = true,
    this.inputType = TextInputType.text,
  });

  @override
  State<CustomPasswordTextfield2> createState() =>
      _CustomPasswordTextfield2State();
}

class _CustomPasswordTextfield2State extends State<CustomPasswordTextfield2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Get.height * 0.02),
      child: TextFormField(
        controller: widget.controller,
        cursorColor: ThemeColors().labelTextColor,
        obscureText: widget.isHidden,
        /*textInputAction: TextInputAction.next,*/
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter ${widget.label}';
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
          labelStyle: TextStyle(
            color: ThemeColors().labelTextColor,
          ),
          hintStyle: TextStyle(
            color: ThemeColors().buttonColor,
            fontSize: 13,
          ),
          labelText: widget.label,
          hintText: 'Enter ${widget.label}',
          suffixIconConstraints: BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),
          suffixIcon: GestureDetector(
            onTap: togglePasswordView,
            child: Padding(
              padding: EdgeInsets.only(
                  right: Get.width * 0.025, top: Get.height * 0.02),
              child: Icon(
                widget.isHidden ? Icons.visibility : Icons.visibility_off,
                size: 23,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void togglePasswordView() {
    setState(() {
      widget.isHidden = !widget.isHidden;
    });
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class CustomTextfield4 extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final String hint;

  const CustomTextfield4({
    Key? key,
    required this.controller,
    required this.label,
    required this.inputType,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ThemeColors().labelTextColor,
      controller: controller,
      keyboardType: inputType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        } else if (inputType == TextInputType.number && !value.isNumericOnly) {
          return "Only enter number's $label";
        } else if (label == "Job Title" && value.length > 50) {
          return "Shouldn't exceed 50 characters";
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
        suffixIconConstraints: const BoxConstraints(
          minWidth: 24,
          minHeight: 24,
        ),
        suffixIcon: IconButton(
          onPressed: controller.clear,
          icon: const Icon(Icons.clear_rounded),
          iconSize: 20,
          color: ThemeColors().iconColor,
        ),
        hintStyle: TextStyle(
          color: ThemeColors().buttonColor,
          fontSize: 18,
        ),
        hintText: hint,
      ),
    );
  }
}

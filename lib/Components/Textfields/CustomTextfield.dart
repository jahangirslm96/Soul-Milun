import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class CustomTextfield extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType inputType;
  final List<TextInputFormatter>? inputFormatters;

  const CustomTextfield({
    Key? key,
    required this.controller,
    required this.label,
    this.inputType = TextInputType.text,
    this.inputFormatters,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    int? maxLength;
    MaxLengthEnforcement maxLengthEnforcement = MaxLengthEnforcement.none;

    if (label == 'CVC') {
      maxLength = 3;
      maxLengthEnforcement = MaxLengthEnforcement.enforced;
    }

    return Container(
      padding: EdgeInsets.only(top: Get.height * 0.02),
      child: TextFormField(
        cursorColor: ThemeColors().labelTextColor,
        controller: controller,
        keyboardType: inputType,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return '$label is missing';
          } else if (label == "Card Number" && value.length < 19) {
            return '$label should be 16 digits';
          } else if (label == "CVC" && value.length < 3) {
            return '';
          } else if (label == "MM/YY" && value.length < 5) {
            return '';
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
          suffixIconConstraints: const BoxConstraints(minWidth: 24, minHeight: 24),
          suffixIcon: Padding(
            padding: EdgeInsets.only(top: Get.height * 0.02),
            child: IconButton(
              onPressed: controller.clear,
              icon: const Icon(Icons.clear_rounded),
              iconSize: 20,
              color: Colors.grey,
            ),
          ),
          labelStyle: TextStyle(
            color: ThemeColors().buttonColor,
          ),
          hintStyle: TextStyle(
            color: ThemeColors().buttonColor,
          ),
          labelText: label,
          hintText: "Enter $label",
          counterText: '', // Add this line to remove the character count indicator
        ),
        inputFormatters: inputFormatters,
        maxLength: maxLength,
        maxLengthEnforcement: maxLengthEnforcement,
      ),
    );
  }
}

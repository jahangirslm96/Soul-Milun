import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class CustomTextfield2 extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType inputType;
  final bool isValid;

  const CustomTextfield2({
    super.key,
    required this.controller,
    this.inputType = TextInputType.number,
    this.isValid = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal: Get.width * 0.019,),
      child: TextFormField(
          inputFormatters: [
            LengthLimitingTextInputFormatter(1),
          ],
        cursorColor: ThemeColors().labelTextColor,
        /*controller: controller,*/
        keyboardType: inputType,
        textInputAction: TextInputAction.next,
        textAlign: TextAlign.center,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        validator: (value) {
          return (value == null || value.isEmpty) && isValid ? '' : null;
        },
        style: TextStyle(
          color: ThemeColors().onBoardingHeadingColor,
        ),
        decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColors().onBoardingHeadingColor,
              width: 1,
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
        ),
      ),
    );
  }
}

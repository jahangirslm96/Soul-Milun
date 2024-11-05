import 'package:flutter/material.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class TextBoxField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;


  const TextBoxField({
    required this.controller,
    required this.label,
    required this.hint,
});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: ThemeColors().labelTextColor,
      controller: controller,
      maxLength: 250,
      /*onChanged: onChanged,*/
      style: TextStyle(
        color: ThemeColors().onBoardingHeadingColor,
      ),
      maxLines: 15,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter $label';
        }
        return null;
        },
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: ThemeColors().containerOutlineColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            width: 2,
            color: ThemeColors().labelTextColor,
          ),
        ),
        errorStyle: TextStyle(
          height: 0,
          color: CustomTheme().errorColor,
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: CustomTheme().errorColor,
            width: CustomTheme().errorBorderWidth,
          ),
        ),
        contentPadding: EdgeInsets.all(CustomTheme().paddingInput),
        hintStyle: TextStyle(
          color: ThemeColors().buttonColor,
          fontSize: 18,
        ),
        hintText: hint,
      ),
    );
  }
}

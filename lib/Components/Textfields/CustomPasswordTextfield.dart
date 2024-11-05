import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class CustomPasswordTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String label;
  final String? Function(String?)? validator;
  final ValueChanged<String>? onChanged;

  const CustomPasswordTextfield({
    Key? key,
    required this.controller,
    required this.label,
    this.validator,
    this.onChanged,
  }) : super(key: key);

  @override
  _CustomPasswordTextfieldState createState() =>
      _CustomPasswordTextfieldState();
}

class _CustomPasswordTextfieldState extends State<CustomPasswordTextfield> {
  bool _obscureText = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Get.height * 0.02),
      child: TextFormField(
        cursorColor: ThemeColors().labelTextColor,
        controller: widget.controller,
        obscureText: _obscureText,
        autovalidateMode: AutovalidateMode.onUserInteraction,
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
          hintStyle: TextStyle(
            color: ThemeColors().buttonColor,
          ),
          hintText: widget.label,
          suffixIconConstraints: BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),
          suffixIcon: IconButton(
            icon: Icon(
              _obscureText ? Icons.visibility : Icons.visibility_off,
              color: ThemeColors().buttonColor,
            ),
            onPressed: () {
              setState(() {
                _obscureText = !_obscureText;
              });
            },
          ),
        ),
        validator: widget.validator,
        onChanged: widget.onChanged,
      ),
    );
  }
}

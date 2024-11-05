// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class OtpInputTextfield extends StatefulWidget {
  final List<TextEditingController> controllers;

  const OtpInputTextfield({super.key, required this.controllers});
  @override
  _OtpInputTextfieldState createState() => _OtpInputTextfieldState();
  final bool isvalid = true;
}

class _OtpInputTextfieldState extends State<OtpInputTextfield> {
  final List<FocusNode> _focusNodes = List.generate(5, (index) => FocusNode());

  @override
  void dispose() {
    for (int i = 0; i < 5; i++) {
      _focusNodes[i].dispose();
      widget.controllers[i].dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 0; i < 5; i++)
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: TextFormField(
                controller: widget.controllers[i],
                cursorColor: ThemeColors().labelTextColor,
                focusNode: _focusNodes[i],
                keyboardType: TextInputType.number,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(1),
                ],
                onChanged: (value) {
                  if (value.isNotEmpty) {
                    if (i < 4) {
                      FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                    } else {
                      _focusNodes[i].unfocus();
                    }
                  } else {
                    if (i > 0) {
                      FocusScope.of(context).requestFocus(_focusNodes[i - 1]);
                    }
                  }
                },
                onEditingComplete: () {
                  if (i < 4) {
                    FocusScope.of(context).requestFocus(_focusNodes[i + 1]);
                  }
                },
                textAlign: TextAlign.center,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) {
                  return (value == null || value.isEmpty) ? '' : null;
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
            ),
          ),
      ],
    );
  }
}

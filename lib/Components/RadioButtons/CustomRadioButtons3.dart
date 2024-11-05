import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class CustomRadioButtons3 extends StatefulWidget {
  final String option1;
  final String option2;
  final String option3;
  final String option4;
  final String option5;

  const CustomRadioButtons3({
    super.key,
    required this.option1,
    required this.option2,
    required this.option3,
    required this.option4,
    required this.option5,
  });

  @override
  State<CustomRadioButtons3> createState() => _CustomRadioButtons3State();
}

class _CustomRadioButtons3State extends State<CustomRadioButtons3> {
  int _selectedOption = 0;
  bool _showTextBox = false; // Flag to show or hide text box

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        RadioListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.06,vertical: Get.height * 0.01),
          activeColor: ThemeColors().buttonColor,
          title: Text(
              widget.option1,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: ThemeColors().buttonColor,
            ),
          ),
          value: 1,
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
              _showTextBox = false; // Hide text box when option is selected
            });
          },
        ),
        RadioListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.06,vertical: Get.height * 0.01),
          activeColor: ThemeColors().buttonColor,
          title: Text(
            widget.option2,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: ThemeColors().buttonColor,
            ),
          ),
          value: 2,
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
              _showTextBox = false; });
            },
        ),
        RadioListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.06,vertical: Get.height * 0.01),
          activeColor: ThemeColors().buttonColor,
          title: Text(
            widget.option3,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: ThemeColors().buttonColor,
            ),
          ),
          value: 3,
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
              _showTextBox = false; // Hide text box when option is selected
            });
          },
        ),
        RadioListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.06,vertical: Get.height * 0.01),
          activeColor: ThemeColors().buttonColor,
          title: Text(
            widget.option4,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.normal,
              fontSize: 16, color: ThemeColors().buttonColor,
            ),
          ),
          value: 4,
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
              _showTextBox = false; // Hide text box when option is selected
            });
            },
        ),
        RadioListTile(
          contentPadding: EdgeInsets.symmetric(horizontal: Get.width * 0.06,vertical: Get.height * 0.01),
          activeColor: ThemeColors().buttonColor,
          title: Text(
            widget.option5,
            style: TextStyle(
              fontFamily: 'Urbanist',
              fontWeight: FontWeight.normal,
              fontSize: 16,
              color: ThemeColors().buttonColor,
            ),
          ),
          value: 5,
          groupValue: _selectedOption,
          onChanged: (value) {
            setState(() {
              _selectedOption = value!;
              _showTextBox = true; // Show text box when option is selected
            });
            },
        ),
        if (_showTextBox) // Display text box conditionally
          Padding(
            padding: EdgeInsets.symmetric(vertical: Get.height * 0.02, horizontal: Get.width * 0.06),
            child: TextFormField(
              cursorColor: ThemeColors().labelTextColor,
              style: TextStyle(
                fontSize: 16,
                color: ThemeColors().onBoardingHeadingColor,
              ),
              maxLines: 5,
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
                hintStyle: TextStyle(color: ThemeColors().buttonColor,),
                hintText: "Specify reason for reporting ...",
              ),
            ),
          ),
      ],
    );
  }
}

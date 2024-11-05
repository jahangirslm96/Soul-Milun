import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class CustomDatePicker extends StatelessWidget {
  final String label;
  final TextEditingController controller;

  const CustomDatePicker({
    super.key,
    required this.label,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    const minimumAge = 18;
    final currentDate = DateTime.now();
    final minimumDate = DateTime(1920);
    final lastDate = DateTime(
        currentDate.year - minimumAge, currentDate.month, currentDate.day);

    return Theme(
      data: ThemeData.light().copyWith(
        colorScheme: ColorScheme.light(
          primary: ThemeColors().buttonColor,
        ),
      ),
      child: DateTimePicker(
        controller: controller,
        style: TextStyle(
          color: ThemeColors().onBoardingHeadingColor,
          fontSize: 18,
          fontFamily: "Urbanist",
        ),
        calendarTitle: "SELECT DATE OF BIRTH",
        decoration: InputDecoration(
          suffixIcon: Icon(
            Icons.calendar_today_outlined,
            color: ThemeColors().buttonColor,
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: ThemeColors().enabledBorderColor,
            ),
          ),
          errorStyle: TextStyle(
            height: 0,
            fontFamily: "Urbanist",
            fontSize: 15,
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
          isDense: true,
          contentPadding: EdgeInsets.all(CustomTheme().paddingInput),
          hintText: label,
          hintStyle: TextStyle(
            color: ThemeColors().buttonColor,
            fontSize: 18,
          ),
        ),
        type: DateTimePickerType.date,
        dateMask: 'dd-MM-yyyy',
        initialDate: DateTime(2005),
        firstDate: minimumDate,
        lastDate: lastDate,
        onChanged: (value) {},
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter Date';
          }
        },
      ),
    );
  }
}

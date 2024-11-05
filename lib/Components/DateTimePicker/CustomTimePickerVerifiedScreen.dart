import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import '../../Utils/CustomTheme.dart';

class CustomTimePickerVerifiedScreen extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator; // Add a validator property

  const CustomTimePickerVerifiedScreen({
    Key? key,
    required this.label,
    required this.controller,
    this.onChanged,
    this.validator, // Pass the validator to the constructor
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final now = TimeOfDay.now();

    return FormField<String>(
      validator: validator, // Use the provided validator here
      builder: (state) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: ColorScheme.light(
              primary: ThemeColors().buttonColor,
            ),
          ),
          child: DateTimePicker(
            validator: validator,
            controller: controller,
            style: TextStyle(
              color: ThemeColors().onBoardingHeadingColor,
              fontSize: 18,
              fontFamily: "Urbanist",
            ),
            calendarTitle: "SELECT TIME",
            decoration: InputDecoration(
              suffixIcon: Icon(
                Icons.access_time,
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
              label: Text(label),
              labelStyle: TextStyle(
                color: ThemeColors().buttonColor,
                fontSize: 18,
              ),
            ),
            type: DateTimePickerType.time,
            initialTime: now,
            onChanged: (value) {
              state.didChange(value);
              onChanged?.call(value);
            },
          ),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

class SearchInput extends StatelessWidget {
  final Function(String text) onChange;
  const SearchInput({super.key, required this.onChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(
        Get.height * 0.02,
      ),
      child: TextFormField(
        onChanged: onChange,
        cursorColor: ThemeColors().labelTextColor,
        style: TextStyle(
          color: ThemeColors().onBoardingHeadingColor,
          fontSize: 14,
        ),
        decoration: InputDecoration(
          isDense: true,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              color: ThemeColors().enabledBorderColor,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50.0),
            borderSide: BorderSide(
              width: 2,
              color: ThemeColors().labelTextColor,
            ),
          ),
          contentPadding: EdgeInsets.symmetric(
              vertical: Get.height * 0.020, horizontal: Get.width * 0.04),
          hintStyle: TextStyle(
            color: ThemeColors().buttonColor,
            fontSize: 14,
          ),
          hintText: "Search",
          suffixIconConstraints: const BoxConstraints(
            minWidth: 24,
            minHeight: 24,
          ),
          suffixIcon: Padding(
            padding: EdgeInsets.only(
              right: Get.width * 0.05,
            ),
            child: Icon(
              Icons.search,
              size: 20,
              color: ThemeColors().iconColor,
            ),
          ),
        ),
      ),
    );
  }
}

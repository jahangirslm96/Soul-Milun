import 'package:flutter/material.dart';
import 'package:flutter_dropdown_search/flutter_dropdown_search.dart';
import 'package:get/get.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final TextEditingController controller;
  final String title;
  final String subTitle;

  const CustomDropDown(
      {super.key,
      required this.items,
      required this.controller,
      required this.title,
      this.subTitle = ""});
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: Get.height * 0.03),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: Theme.of(context).textTheme.labelMedium,
              ),
              Text(
                subTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
        ),
        FlutterDropdownSearch(
          // dropdownBgColor,
          hintText: "Select a $title",
          textController: controller,
          items: items,
          dropdownHeight: Get.height * 0.2,
        ),
      ],
    );
  }
}

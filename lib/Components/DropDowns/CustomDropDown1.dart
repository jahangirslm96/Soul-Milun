import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';

class CustomDropDown1 extends StatelessWidget {
  final List<dynamic> productItems;
  String product;
  final onChanged;
  final String label;

  CustomDropDown1({
    super.key,
    required this.productItems,
    required this.onChanged,
    required this.label,
    this.product = "",
  });

  @override
  Widget build(BuildContext context) {
    if (product.isEmpty && productItems.isNotEmpty) {
      product = productItems[0];
    }

    return DropdownButtonFormField2(
      value: product,
      onChanged: onChanged,
      style: TextStyle(
        color: ThemeColors().onBoardingHeadingColor,
      ),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      validator: (value) {
        if (value == null) {
          return 'Please select $label';
        }
        return null;
      },
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
        isDense: true,
        contentPadding:
            const EdgeInsets.only(top: 14, bottom: 14, left: 0, right: 14),
        hintStyle: TextStyle(
          color: ThemeColors().buttonColor,
          fontSize: 18,
        ),
        hintText: label,
      ),
      items: productItems.map((item) {
        bool isSelected = (item == product);
        return DropdownMenuItem(
          value: item,
          child: Row(
            children: [
              Text(
                item,
                maxLines: 1,
                style: TextStyle(
                  color: ThemeColors().buttonColor,
                  fontSize: 18,
                  fontFamily: "Urbanist",
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
              ),
            ],
          ),
        );
      }).toList(),
      selectedItemBuilder: (BuildContext context) {
        return productItems.map((item) {
          return Text(
            item,
            style: TextStyle(
              color: ThemeColors().buttonColor,
              fontSize: 18,
              fontFamily: "Urbanist",
            ),
          );
        }).toList();
      },
    );
  }
}

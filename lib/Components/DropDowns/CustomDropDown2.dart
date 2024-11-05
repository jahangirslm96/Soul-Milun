import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';

import '../../Utils/ThemeColors.dart';

class CustomDropDown2 extends StatelessWidget {
  final List<String> productItems;
  String product;
  final onChanged;
  final String label;

  CustomDropDown2({
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
    return SizedBox(
      width: 170,
      child: DropdownButtonFormField2(
        alignment: AlignmentDirectional.center,
        value: product,
        iconStyleData: IconStyleData(
          iconDisabledColor: Colors.white,
          iconEnabledColor: Colors.white,
        ),
        onChanged: onChanged,
        style: TextStyle(
          color: ThemeColors().onBoardingHeadingColor,
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          isDense: true,
          hintStyle: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
          hintText: label,
          // contentPadding:
          //     const EdgeInsets.only(top: 14, bottom: 14, left: 0, right: 20),
        ),
        items: productItems.map((item) {
          bool isSelected = (item == product);
          return DropdownMenuItem(
            value: item,
            child: Row(
              children: [
                Text(
                  item,
                  style: TextStyle(
                    color: ThemeColors().buttonColor,
                    fontSize: 18,
                    fontFamily: "Urbanist",
                    fontWeight:
                        isSelected ? FontWeight.bold : FontWeight.normal,
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
                color: Colors.white,
                fontSize: 18,
                fontFamily: "Urbanist",
              ),
            );
          }).toList();
        },
      ),
    );
  }
}

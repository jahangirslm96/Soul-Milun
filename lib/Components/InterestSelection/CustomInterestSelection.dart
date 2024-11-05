// CustomInterestSelection.dart
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';

import '../../Utils/ThemeColors.dart';
import '../Buttons/CustomButton.dart';

class CustomInterestSelection extends StatefulWidget {
  final String image;
  final String name;
  final num padding;
  final List<dynamic> nameOfArray;
  final List<String> selectionInterestArray;
  final Function() onSelectionChanged; // Callback function

  const CustomInterestSelection({
    Key? key,
    required this.image,
    required this.name,
    required this.padding,
    required this.nameOfArray,
    required this.selectionInterestArray,
    required this.onSelectionChanged, // Pass the callback
  }) : super(key: key);

  @override
  State<CustomInterestSelection> createState() =>
      _CustomInterestSelectionState();
}

class _CustomInterestSelectionState extends State<CustomInterestSelection> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: Get.height * widget.padding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.network(
                assestUrl + widget.image,
                scale: 10,
              ),
              SizedBox(
                width: Get.width * 0.04,
              ),
              Text(
                widget.name,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors().buttonColor,
                ),
              ),
            ],
          ),
          Padding(
            padding: EdgeInsets.only(top: Get.height * 0.03),
            child: Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              children: widget.nameOfArray.map((word) {
                final isSelected =
                    widget.selectionInterestArray.contains(word["tagId"]);
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      if (isSelected) {
                        widget.selectionInterestArray.remove(word["tagId"]);
                      } else {
                        if (widget.selectionInterestArray.length >= 15) {
                          // //print("ssds");
                          // bad mein kuch agaya mujha yaad raha toh bata dunga
                        } else {
                          widget.selectionInterestArray.add(word["tagId"]);
                        }
                      }
                      widget.onSelectionChanged(); // Call the callback function
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10.0, horizontal: 12),
                    decoration: BoxDecoration(
                        color: isSelected
                            ? ThemeColors().buttonColor
                            : ThemeColors().scaffoldColor,
                        borderRadius: BorderRadius.circular(20.0),
                        border: Border.all(
                          color: isSelected
                              ? ThemeColors().buttonColor
                              : ThemeColors().gridPartnerProfileColor,
                        )),
                    child: Text(
                      word["tagName"],
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14,
                        color: isSelected
                            ? Colors.white
                            : ThemeColors().buttonColor,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

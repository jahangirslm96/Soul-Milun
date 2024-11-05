import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/ThemeColors.dart';
import '../Buttons/CustomButton.dart';

class DialogBox1 extends StatelessWidget {

  final String heading;
  final String subHeading;
  final String buttonText;
  final dynamic onTap;

  const DialogBox1({
    Key? key,
    required this.heading,
    required this.subHeading,
    required this.buttonText,
    required this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
            vertical: Get.height * 0.01,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "SOUL",
                    style: TextStyle(
                      color: ThemeColors().soulColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: " MILUN",
                        style: TextStyle(
                          color: ThemeColors().milanColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.02),
                child: Center(
                  child: Text(
                    heading,
                    style: TextStyle(
                      color: ThemeColors().buttonColor,
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.04),
                  child: Text(
                    subHeading,
                    style: TextStyle(
                      color: ThemeColors().buttonColor,
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.04),
                child: CustomButton(
                  name: buttonText,
                  onClick: onTap,
                  color: ThemeColors().buttonColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

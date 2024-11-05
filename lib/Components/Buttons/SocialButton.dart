import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

import '../../Screens/Authentication/Login/LoginScreen.dart';
import '../../Utils/Constants.dart';

class SocialButton extends StatelessWidget {
  final String label;
  final String icon;
  final Function()? ontap;

  SocialButton({
    super.key,
    required this.label,
    required this.icon,
    required this.ontap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.all(
            Radius.circular(7.0),
          ),
          border: Border.all(
            color: ThemeColors().containerOutlineColor,
          ),
          boxShadow: shadowConstant,
        ),
        child: ListTile(
          leading: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.05),
            child: Image.asset(
              icon,
              height: 24,
              width: 24,
            ),
          ),
          title: Padding(
            padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02),
            child: Text(
              "Continue with $label",
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
        ),
      ),
    );
  }
}

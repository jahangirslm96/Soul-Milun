import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:soul_milan/view_model/SubscriptionPackage_ViewModel.dart';

import '../../Utils/Controller/constant.dart';
import '../../Utils/Controller/model/PackageDetails.model.dart';

class CustomRow extends StatelessWidget {
  final int index;
  final Color containerColor = ThemeColors().roundedContainerColor;
  final Color borderColor = ThemeColors().roundedContainerColor;
  final bool isSpecial;
  final Function(int) onClick;

  CustomRow({
    super.key,
    required this.index,
    this.isSpecial = false,
    required this.onClick,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onClick(index),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.045),
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: Get.height * 0.010, horizontal: Get.width * 0.025),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                profileSettingsRows[index]["title"],
                style: TextStyle(
                  fontSize: 14,
                  color: ThemeColors().buttonColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ClipOval(
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: isSpecial
                        ? ThemeColors().scaffoldColor
                        : containerColor,
                    border: Border.all(
                      color: isSpecial ? ThemeColors().soulColor : borderColor,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: Get.height * 0.02,
                        horizontal: Get.width * 0.02),
                    child: Consumer<SubscriptionPackage_ViewModel>(builder: (context, value, child) => 
                      Icon(
                      //instead of picking icon from profile setting rows, we have directly call icons for become income generator
                        isSpecial
                            ? value.currentPackageType != PackageType.NONE
                                ? Icons.lock_open
                                : Icons.lock
                            : profileSettingsRows[index]["icon"],
                        color: ThemeColors().buttonColor,
                        size: 18,
                      )
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

import '../../Utils/Routes.dart';

class CongratulationsScreen extends StatefulWidget {
  const CongratulationsScreen({Key? key}) : super(key: key);

  @override
  State<CongratulationsScreen> createState() => _CongratulationsScreenState();
}

class _CongratulationsScreenState extends State<CongratulationsScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          
          child: Padding(
            padding: mainBodyPadding,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: Get.height * 0.06,
                ),
                Image.asset(
                  "assets/images/Sample_Demo_Image.png",
                  fit: BoxFit.fill,
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.035, bottom:Get.height * 0.035,),
                  child: Text(
                    "Congratulations!",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: ThemeColors().buttonColor,
                      fontSize: 20,
                    ),
                  ),
                ),
                Text(
                  "You are now a Soulmilun Member.\nWe hope, you do find the right Soul.",
                  style: Theme.of(context).textTheme.labelSmall,
                  textAlign: TextAlign.center,
                ),
                Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.15,),
                  child: CustomButton(
                      name: "Continue",
                      onClick: nextScreen,
                      color: ThemeColors().buttonColor
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void nextScreen() async {
    Get.toNamed(RoutesClass.homeScreen);
  }
}

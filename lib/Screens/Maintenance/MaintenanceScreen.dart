// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Routes.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';


class MaintenanceScreen extends StatefulWidget {
  const MaintenanceScreen({Key? key}) : super(key: key);

  @override
  State<MaintenanceScreen> createState() => _MaintenanceScreenState();
}

class _MaintenanceScreenState extends State<MaintenanceScreen> {

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: subscriptionBodyPadding,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.018,
                    ),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "SOUL",
                          style: TextStyle(
                            color: ThemeColors().soulColor,
                            fontSize:
                            CustomTheme().soulMilanSubscriptionFontSize,
                            fontWeight: FontWeight.bold,
                          ),
                          children: [
                            TextSpan(
                              text: " MILUN",
                              style: TextStyle(
                                color: ThemeColors().milanColor,
                                fontSize:
                                CustomTheme().soulMilanSubscriptionFontSize,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: mainBodyPadding,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "App Under Maintenance: We'll Be Back Soon!",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 24,
                          color: ThemeColors().buttonColor,
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding:
                          EdgeInsets.symmetric(vertical: Get.height * 0.1),
                          child: Image.asset(
                            "assets/images/maintenance_screen_image.jpg",
                            scale: 6,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: mainBodyPadding,
                child: Padding(
                  padding: EdgeInsets.only(bottom: Get.height * 0.06),
                  child: Column(
                    children: [
                      Padding(
                        padding:
                        EdgeInsets.symmetric(vertical: Get.height * 0.01),
                        child: CustomButton(
                          name: "Try Again",
                          onClick: () => Get.offAndToNamed(RoutesClass.splash),
                          color: ThemeColors().buttonColor,
                        ),
                      ),
                    ],
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

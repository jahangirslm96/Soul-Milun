import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Components/Buttons/CustomButton.dart';
import '../../Utils/Constants.dart';
import '../../Utils/CustomTheme.dart';
import '../../Utils/ThemeColors.dart';
import '../../Utils/Routes.dart';

class InternetConnectionScreen extends StatefulWidget {
  const InternetConnectionScreen({Key? key}) : super(key: key);

  @override
  State<InternetConnectionScreen> createState() => _InternetConnectionScreenState();
}

class _InternetConnectionScreenState extends State<InternetConnectionScreen> {
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
                          "Oops! It seems your device is not connected to Internet!",
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
                              "assets/images/no_internet_connection.png",
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
                      ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: const Icon(
                          Icons.error_outline,
                          color: Colors.red,
                          size: 40,
                        ),
                        title: Text(
                          "Please check your internet connection to ensure the app functions properly.",
                          style: TextStyle(
                            color: ThemeColors().buttonColor,
                            fontSize: 16,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ),
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

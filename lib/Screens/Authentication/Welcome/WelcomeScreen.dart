import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Common/varaible.dart';
import 'package:show_up_animation/show_up_animation.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Components/Buttons/SocialButton.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:soul_milan/Utils/Constants.dart';

import '../../../Utils/Routes.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.white,
      statusBarIconBrightness: Brightness.dark, // status bar color
    ));

    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: mainBodyPadding,
              child: Column(
                children: [
                  Center(
                    child: Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.01),
                      child: Image.asset(
                        'assets/images/soulmilan_flower_logo.png',
                        height: Get.height * 0.25,
                        width: Get.width * 0.6,
                      ),
                    ),
                  ),
                  Center(
                    child: ShowUpAnimation(
                      animationDuration: const Duration(milliseconds: 900),
                      delayStart: const Duration(milliseconds: 300),
                      curve: Curves.decelerate,
                      direction: Direction.vertical,
                      offset: 0.5,
                      child: Text.rich(
                        TextSpan(
                            text: 'SOUL',
                            style: Theme.of(context).textTheme.displayLarge,
                            children: [
                              TextSpan(
                                text: ' MILUN',
                                style:
                                    Theme.of(context).textTheme.displayMedium,
                              ),
                            ]),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                  ShowUpAnimation(
                    animationDuration: const Duration(milliseconds: 1200),
                    delayStart: const Duration(milliseconds: 400),
                    curve: Curves.decelerate,
                    direction: Direction.vertical,
                    offset: 0.5,
                    child: Text(
                      "Welcome to Soulmilun",
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.04,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * 0.03),
                    child: Column(
                      children: [
                        SocialButton(
                          ontap: socailLogin,
                          label: "Google",
                          icon: 'assets/icons/Social/googleicon.png',
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        SocialButton(
                          label: "Facebook",
                          icon: 'assets/icons/Social/facebookicon.png',
                          ontap: socailLogin,
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        SocialButton(
                          ontap: toLoginScreen,
                          label: "Email",
                          icon: 'assets/icons/Social/mailicon.png',
                        ),
                        SizedBox(
                          height: Get.height * 0.03,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Divider(
                                color: ThemeColors().containerOutlineColor,
                                thickness: Get.height * 0.002,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.symmetric(
                                  horizontal: Get.width * 0.04),
                              child: Text(
                                "or",
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: ThemeColors().containerOutlineColor,
                                thickness: Get.height * 0.002,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: Get.height * 0.02,
                        ),
                        CustomButton(
                          name: "Sign Up",
                          onClick: nextScreen,
                          color: ThemeColors().buttonColor,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void socailLogin() async {
    Get.snackbar(
        "Sorry, Social Login not work", "we are working on social login");
  }

  void nextScreen() async {
    storge.write("screen", RoutesClass.signupPage);
    Get.toNamed(RoutesClass.signupPage);
  }

  void toLoginScreen() async {
    storge.write("screen", RoutesClass.logInPage);
    Get.toNamed(RoutesClass.logInPage);
  }
}

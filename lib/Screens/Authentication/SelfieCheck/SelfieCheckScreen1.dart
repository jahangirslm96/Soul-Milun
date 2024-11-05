import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

import '../../../Components/Headers/HeaderWithBackIcon.dart';
import '../../../Utils/CustomTheme.dart';
import '../../../Utils/Routes.dart';

class SelfieCheckScreen1 extends StatelessWidget {
  const SelfieCheckScreen1({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: Column(
          children: [
            Padding(
              padding: headerPadding,
              child: const HeaderWithBackIcon(
                title: "Selfie Verification",
                subtitle: "Please, verify your identity.",
              ),
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/selfie_screen_pic.png",
                  ),
                ],
              ),
            ),
            Padding(
              padding: mainBodyPadding4,
              child: Text.rich(
                TextSpan(
                  text: "Note:",
                  style: TextStyle(
                    color: CustomTheme().errorColor,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  children: [
                    TextSpan(
                      text:
                      " Selfie verification is an essential step in our identity verification process. It helps us ensure the authenticity and security of user accounts.",
                      style: TextStyle(
                        color: ThemeColors().buttonColor,
                        fontSize: 16,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: mainBodyPadding,
              child: Padding(
                padding: EdgeInsets.only(bottom: Get.height * 0.02),
                child: CustomButton(
                  name: "Take a Selfie",
                  onClick: () async => await nextScreen(context),
                  color: ThemeColors().buttonColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> nextScreen(BuildContext context) async  {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16.0),
          topRight: Radius.circular(16.0),
        ),
      ),
      builder: (BuildContext context) {
        return Padding(
          padding: mainBodyPadding,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Please make sure selfie contains:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: ThemeColors().buttonColor,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.04),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: Get.height * 0.05,
                              width: Get.width * 0.2,
                              child: Image.asset(
                                "assets/images/clear_face.png",
                              ),
                            ),
                            SizedBox(height: Get.height * 0.02,),
                            Text(
                              "Clear Face",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ThemeColors().buttonColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * 0.03,),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: Get.height * 0.05,
                              width: Get.width * 0.2,
                              child: Image.asset(
                                "assets/images/no_sunglasses.png",
                              ),
                            ),
                            SizedBox(height: Get.height * 0.02,),
                            Text(
                              "No Glasses",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ThemeColors().buttonColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(width: Get.width * 0.03,),
                    Expanded(
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: Get.height * 0.02),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            SizedBox(
                              height: Get.height * 0.05,
                              width: Get.width * 0.2,
                              child: Image.asset(
                                "assets/images/no_makeup.png",
                              ),
                            ),
                            SizedBox(height: Get.height * 0.02,),
                            Text(
                              "No Makeup",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ThemeColors().buttonColor,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.02),
                child: CustomButton(
                  name: "Proceed",
                  onClick: () => Get.offAndToNamed(RoutesClass.selfieCamera),
                  color: ThemeColors().buttonColor,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

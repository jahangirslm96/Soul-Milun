import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';

import '../../Components/Headers/ProfileHeader.dart';
import '../../Components/NavigationBar/CustomBottomNavigationBar.dart';
import '../../Components/Rows/ProfileInfoRow.dart';
import '../../Utils/Routes.dart';

class ProfileCompleteScreen extends StatefulWidget {
  const ProfileCompleteScreen({Key? key}) : super(key: key);

  @override
  State<ProfileCompleteScreen> createState() => _ProfileCompleteScreenState();
}

class _ProfileCompleteScreenState extends State<ProfileCompleteScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: subscriptionBodyPadding,
                child: Column(
                  children: [
                    SizedBox(
                      height: Get.height * 0.018,
                    ),
                    const ProfileHeader(
                      title: "Profile",
                    )
                  ],
                ),
              ),
              Padding(
                padding: mainBodyPadding,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const ProfileInfoRow(),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: Get.height * 0.02),
                      child: Text(
                        "0 Followers",
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeColors().onBoardingHeadingColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.4),
                      child: Center(
                        child: Text(
                          "Verify your Profile with a Selfie.",
                          style: TextStyle(
                            color: ThemeColors().soulColor,
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.01),
                      child: Center(
                        child: Text(
                          "Complete Match My Perfect Soul ",
                          style: TextStyle(
                            color: ThemeColors().soulColor,
                            fontWeight: FontWeight.w100,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.02),
                      child: CustomButton(
                        name: "Complete Profile",
                        onClick: nextScreen,
                        color: ThemeColors().buttonColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(),
      ),
    );
  }

  void nextScreen() async {
    /*if (_formKey.currentState!.validate()) {*/
    Get.toNamed(RoutesClass.selfieCheckScreen);
    /*}*/
  }
}

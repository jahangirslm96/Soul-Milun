import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Constants.dart';

import '../../../Utils/Routes.dart';
import '../../../Utils/ThemeColors.dart';
class SaveAccountScreen extends StatefulWidget {
  const SaveAccountScreen({Key? key}) : super(key: key);

  @override
  State<SaveAccountScreen> createState() => _SaveAccountScreenState();
}

class _SaveAccountScreenState extends State<SaveAccountScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: SingleChildScrollView(
            child: Padding(
              padding: mainBodyPadding,
              child: Column(
                children: [
                  Center(
                    child: Text.rich(
                      TextSpan(
                          text: 'SOUL',
                          style: Theme.of(context).textTheme.displayLarge,
                          children:[
                            TextSpan(
                              text: ' MILUN',
                              style: Theme.of(context).textTheme.displayMedium,
                            ),
                          ]
                      ),
                    ),
                  ),
                  SizedBox(
                    height: Get.height * 0.08,
                  ),
                  Row(
                    children: [
                      Image.asset(
                        "assets/images/sample_profile_pic_male.png",
                        scale: 7,
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: Get.width * 0.04, bottom:Get.height * 0.021),
                        child: Text(
                          "Username",
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.519),
                    child: CustomButton(
                      name: "Save your info",
                      onClick: nextScreen,
                      color: ThemeColors().buttonColor,
                    ),
                  ),
                  CustomButton(
                    name: "Not Now",
                    onClick: nextScreen,
                    color: ThemeColors().buttonColor,
                  ),
                ],
              ),
            ),
          ),
        ),
    );
  }
  void nextScreen() async {
    Get.toNamed(RoutesClass.policyScreen);
  }
}

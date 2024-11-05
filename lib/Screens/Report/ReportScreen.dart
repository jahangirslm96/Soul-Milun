import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Routes.dart';

import '../../Components/Buttons/CustomButton.dart';
import '../../Components/Headers/CustomHeader.dart';
import '../../Components/RadioButtons/CustomRadioButtons3.dart';
import '../../Utils/ThemeColors.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({Key? key}) : super(key: key);

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  late bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: AbsorbPointer(
            absorbing: isLoading,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04, vertical: 12),
                  child: const Column(
                    children: [
                      CustomHeader(
                        name: "Report Profile",
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: ThemeColors().containerOutlineColor,
                  thickness: Get.height *0.0005,
                ),
                Padding(
                  padding: mainBodyPadding,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Note",
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeColors().buttonColor,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: Get.height * 0.01, bottom: Get.height*0.02),
                        child: Text(
                          "If someone is in immediate danger, get help before reporting to the support",
                          style: TextStyle(
                            fontSize: 16,
                            color: ThemeColors().helpCenterHintColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const CustomRadioButtons3(
                  option1: "Fake Profile",
                  option2: "Posting inappropriate things",
                  option3: "Harassment",
                  option4: "Bullying",
                  option5: "Other",
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                  child: Padding(
                    padding: EdgeInsets.only(top: Get.height * 0.02),
                    child: CustomButton(
                      name: "Submit",
                      onClick: nextScreen,
                      isLoading: isLoading,
                      color: ThemeColors().buttonColor,
                    ),
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
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    Get.toNamed(RoutesClass.homeScreen);

    Get.snackbar(
        backgroundColor: ThemeColors().buttonColor,
        colorText: Colors.white,
        "Reported",
        "Request has been successfully submitted!",
        duration: const Duration(seconds: 5),
    );

    setState(() {
      isLoading = false;
    });
  }
}

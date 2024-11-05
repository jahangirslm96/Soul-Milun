import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Components/Textfields/TextBoxField.dart';
import 'package:soul_milan/Utils/ThemeColors.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Components/Headers/CustomHeader.dart';
import '../../Utils/Constants.dart';
import '../../Utils/CustomTheme.dart';

class HelpCenterScreen extends StatefulWidget {
  const HelpCenterScreen({Key? key}) : super(key: key);

  @override
  State<HelpCenterScreen> createState() => _HelpCenterScreenState();
}

class _HelpCenterScreenState extends State<HelpCenterScreen> {
  late bool isLoading = false;
  TextEditingController messageController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: subscriptionBodyPadding,
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: Get.height * 0.018,
                      ),
                      const CustomHeader(
                        name: "Help Center",
                      ),
                    ],
                ),
              ),
              Padding(
                padding: mainBodyPadding,
                child: Padding(
                  padding: EdgeInsets.only(top: Get.height * 0.02,),
                  child: Text(
                    "Contact:",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 16,
                      color: ThemeColors().buttonColor,
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: () async {
                    final call = Uri.parse('tel:+92 3334444555');
                    if (await canLaunchUrl(call)) {
                  launchUrl(call);
                  } else {
                  throw 'Could not launch $call';
                  }
                },
                child: Container(
                  padding: EdgeInsets.symmetric(vertical: Get.height * 0.025,horizontal: Get.width * 0.08),
                  child: Row(
                    children: [
                      Icon(
                        Icons.phone_sharp,
                        color: ThemeColors().buttonColor,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Get.width * 0.02,),
                        child: Text(
                          "+92 3334444555",
                          style: TextStyle(
                            fontSize: 18,
                            color: ThemeColors().helpCenterPhoneNumberColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Get.width * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.02,),
                      child: Text(
                        "If you have any Query, Email us.",
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          color: ThemeColors().buttonColor,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.02),
                      child: TextBoxField(
                        label: "Message",
                        controller: messageController,
                        hint: "Message us. Type here...",
                      )
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.05, bottom: Get.height * 0.02),
                      child: CustomButton(
                        name: "Email Now",
                        isLoading: isLoading,
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
      ),
    );
  }
  void nextScreen() async {
    setState(() {
      isLoading = true;
    });
    await Future.delayed(const Duration(seconds: 2));
    Get.back();

    Get.snackbar(
      backgroundColor: ThemeColors().buttonColor,
      colorText: Colors.white,
      "Email Sent",
      "Your mail has been sent to Help Center.",
      duration: const Duration(seconds: 5),
    );
    setState(() {
      isLoading = false;
    });
  }
}

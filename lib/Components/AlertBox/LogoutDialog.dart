import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Utils/ThemeColors.dart';
import '../Buttons/CustomButton.dart';

class LogoutDialog extends StatefulWidget {
  final VoidCallback onLogout;

  LogoutDialog({required this.onLogout});

  @override
  _LogoutDialogState createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  bool isLoggingOut = false;

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Get.width * 0.05,
            vertical: Get.height * 0.01,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "SOUL",
                    style: TextStyle(
                      color: ThemeColors().soulColor,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    children: [
                      TextSpan(
                        text: " MILUN",
                        style: TextStyle(
                          color: ThemeColors().milanColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(
                    top: Get.height * 0.02,
                  ),
                  child: Text(
                    "Are you sure you want to Logout?",
                    style: TextStyle(
                      color: ThemeColors().buttonColor,
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: Get.height * 0.02),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: CustomButton(
                        name: 'Yes',
                        onClick: () async {
                          Navigator.of(context).pop();

                          setState(() {
                            isLoggingOut = true;
                          });

                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (BuildContext context) => SimpleDialog(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20),
                              ),
                              children: [
                                Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: Get.width * 0.05,
                                        vertical: Get.height * 0.02,
                                      ),
                                      child: Column(
                                        children: [
                                          CircularProgressIndicator(
                                            color: ThemeColors().soulColor,
                                          ),
                                          SizedBox(
                                            height: Get.height * 0.02,
                                          ),
                                          Text(
                                            "Logging you out...",
                                            style: TextStyle(
                                              color: ThemeColors().buttonColor,
                                              fontSize: 17,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );

                          await Future.delayed(const Duration(seconds: 2));

                          widget.onLogout();
                        },
                        color: ThemeColors().soulColor,
                      ),
                    ),
                    SizedBox(
                      width: Get.width * 0.04,
                    ),
                    Expanded(
                      child: CustomButton(
                        name: 'No',
                        onClick: () {
                          Get.back();
                        },
                        color: ThemeColors().milanColor,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

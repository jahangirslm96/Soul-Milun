import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Components/Buttons/CustomButton.dart';
import 'package:soul_milan/Utils/Routes.dart';

import '../../Components/Headers/CustomHeader.dart';
import '../../Utils/Constants.dart';
import '../../Utils/ThemeColors.dart';

class ChatRequestScreen extends StatefulWidget {
  const ChatRequestScreen({Key? key}) : super(key: key);

  @override
  State<ChatRequestScreen> createState() => _ChatRequestScreenState();
}

class _ChatRequestScreenState extends State<ChatRequestScreen> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: subscriptionBodyPadding,
              child: Column(
                children: [
                  SizedBox(
                    height: Get.height * 0.018,
                  ),
                  const CustomHeader(
                    name: "Chat Request",
                  ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: mainBodyPadding4,
                child: Column(
                  children: [
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Image.asset(
                          'assets/images/chat_pic1.png',
                          scale: 8.0,
                      ),
                      title: Text(
                        "Fahad Khan",
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeColors().buttonColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Row(
                        children: [
                          Text(
                            "Karachi, Pakistan",
                            style: TextStyle(
                              fontSize: 12,
                              color: ThemeColors().buttonColor,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: Get.height * 0.5,
                      padding: EdgeInsets.only(top: Get.height * 0.01),
                      child: Image.asset(
                        "assets/images/chat_Request_Image.png",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.02),
                      child: Text(
                        textAlign: TextAlign.center,
                        "Fahad Khan has sent you the message request. This might be interesting\nmessage for you ;)",
                        style: TextStyle(
                          fontSize: 18,
                          color: ThemeColors().buttonColor,
                          fontWeight: FontWeight.normal,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: Get.height * 0.04),
                      child: CustomButton(
                        name: "See Message",
                        onClick: () {
                          Get.toNamed(RoutesClass.chatScreen2);
                        },
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
    );
  }
}
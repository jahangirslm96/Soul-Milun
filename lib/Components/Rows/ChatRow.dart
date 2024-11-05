import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/chat.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';

import '../../Utils/ThemeColors.dart';

class ChatRow extends StatefulWidget {
  final ChatModel chatHead;

  const ChatRow({
    super.key,
    required this.chatHead,
  });

  @override
  State<ChatRow> createState() => _ChatRowState();
}

class _ChatRowState extends State<ChatRow> {
  late ChatModel chat;
  late DateTime time;
  late int days = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chat = widget.chatHead;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
      child: GestureDetector(
        onTap: () {
          Get.toNamed(RoutesClass.chatScreen2);
          chatPreview = chat;
        },
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: Get.width * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomTheme().successColor,
                width: chat.isOnline ? 3 : 0,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  connector.api.fileUrl + chat.profile.profileImage,
                ),
                fit: BoxFit.cover,
              ),
            ),
          ),
          title: Text(
            chat.profile.name,
            style: TextStyle(
              fontSize: 18,
              color: ThemeColors().buttonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              chat.lastMessage.type == 1
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.check_sharp,
                        color: ThemeColors().buttonColor,
                        size: 10,
                      ),
                    )
                  : Container(),
              Text(
                chat.lastMessage.message.length > 35
                    ? "${chat.lastMessage.message.substring(0, 35)}..."
                    : chat.lastMessage.message,
                style: TextStyle(
                  fontSize: 12,
                  color: ThemeColors().buttonColor,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
          trailing: Column(
            children: [
              chat.unreadMessage
                  ? Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: ThemeColors().buttonColor,
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          "",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 12,
                            color: ThemeColors().scaffoldColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
              Text(
                chat.lastMessage.timeDifference_(),
                style: TextStyle(
                  fontSize: 12,
                  color: ThemeColors().buttonColor,
                  fontWeight: FontWeight.w100,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

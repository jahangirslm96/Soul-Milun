import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:soul_milan/Utils/Constants.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/chat.model.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';
import 'package:soul_milan/view_model/SoulProfile_ViewModel.dart';

import '../../Utils/Controller/model/customChatHead.model.dart';
import '../../Utils/ThemeColors.dart';
import '../../view_model/MessengerChat_ViewModel.dart';

class CustomChatRow extends StatefulWidget {
final CustomChatHead customChatHead;

  const CustomChatRow({
    Key? key,
    required this.customChatHead,
  }) : super(key: key);

  @override
  State<CustomChatRow> createState() => _CustomChatRowState();
}

class _CustomChatRowState extends State<CustomChatRow> {
  late CustomChatHead? chat;
  late DateTime time;
  late int days = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    chat = widget.customChatHead;
  }

  @override
  Widget build(BuildContext context) {
    SoulProfile_ViewModel soulProfile_ViewModel = Provider.of<SoulProfile_ViewModel>(context);
    MessengerChat_ViewModel messengerChat_ViewModel = Provider.of<MessengerChat_ViewModel>(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Get.height * 0.005),
      child: GestureDetector(
        onTap: () {
          messengerChat_ViewModel.setCurrentChat(chat!);
          if (messengerChat_ViewModel.currentChat!.unread &&
              messengerChat_ViewModel.currentChat!.lastMessage?.senderId != soulProfile_ViewModel.profileVerification!.uID) {
            channel.emitWithAck("message-status", {
              "receiverId": messengerChat_ViewModel.currentChat!.profile.uID,
              "chatID": messengerChat_ViewModel.currentChat!.chatId,
              "sendBy": soulProfile_ViewModel.profileVerification!.uID,
            }, ack: (data) {
              // data.map((e) {
            });
            messengerChat_ViewModel.currentChat!.unread = false;
          }
          // currentChat.unread = false;
          Get.toNamed(RoutesClass.chattingScreen);
        },
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: Container(
            width: Get.width * 0.15,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: CustomTheme().successColor,
                //width: chat.isOnline ? 3 : 0,
              ),
              image: DecorationImage(
                image: NetworkImage(
                  connector.api.fileUrl + chat!.profile.image,
                ),
                fit: BoxFit.contain,
              ),
            ),
          ),
          title: Text(
            chat!.profile.name,
            style: TextStyle(
              fontSize: 18,
              color: ThemeColors().buttonColor,
              fontWeight: FontWeight.bold,
            ),
          ),
          subtitle: Row(
            children: [
              chat!.lastMessage?.senderId == soulProfile_ViewModel.profileVerification!.uID &&
                      chat!.unread == true
                  ? Padding(
                      padding: const EdgeInsets.only(right: 5),
                      child: Icon(
                        Icons.check_sharp,
                        color: ThemeColors().buttonColor,
                        size: 10,
                      ),
                    )
                  : chat!.lastMessage?.senderId == soulProfile_ViewModel.profileVerification!.uID &&
                          chat!.unread == false
                      ? Padding(
                          padding: const EdgeInsets.only(right: 5),
                          child: Icon(
                            Icons.check_sharp,
                            color: Colors.blue[900],
                            size: 15,
                          ),
                        )
                      : Container(),
              Expanded(child: 
              // Text(
              //   chat!.lastMessage!.message, //we will show booking acceptance popup
              //   maxLines: 1,
              //   overflow: TextOverflow.ellipsis,
              //   style: TextStyle(
              //     fontSize: 12,
              //     color: ThemeColors().buttonColor,
              //     fontWeight: FontWeight.w100,
              //   ),
              // )
              _buildTextwidget(soulProfile_ViewModel)
            ),
            ],
          ),
          trailing: Column(
            children: [
              chat!.unread &&
                      chat!.lastMessage?.senderId != soulProfile_ViewModel.profileVerification!.uID
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
              const SizedBox(),
              Text(
                chat!.timeDifference_(),
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

  _buildTextwidget(SoulProfile_ViewModel soulProfile_ViewModel){
    // List<String> voiceMessageData = chat.lastMessage!.message.split('_');
    // print(voiceMessageData);
  if(chat!.lastMessage!.messageCode == "voice"){
    return Row(
      children: [
        Icon(
          Icons.mic,
          color: ThemeColors().buttonColor,
          size: 20,
        ),
      Text(
          " voice message",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: ThemeColors().buttonColor,
            fontWeight: FontWeight.w100,
          ),
        )
      ],
    );
  }else if(chat!.lastMessage!.messageCode == "tourer" && chat!.lastMessage!.TOID != null){
    return Row(
      children: [
        Icon(
          Icons.car_rental_sharp,
          color: ThemeColors().buttonColor,
          size: 20,
        ),
      Text(
          chat!.lastMessage!.senderId != soulProfile_ViewModel.profileOverview!.profileData!.uId! ? chat!.profile.name  : "You sent tourer request.",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: ThemeColors().buttonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          chat!.lastMessage!.senderId != soulProfile_ViewModel.profileOverview!.profileData!.uId! ? " sent you tourer request." : "",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: ThemeColors().buttonColor,
            fontWeight: FontWeight.w100,
          ),
        )
      ],
    );
  }else if(chat!.lastMessage!.messageCode == "tourer" && chat!.lastMessage!.TOID == null){
    return Row(
      children: [
        Icon(
          Icons.car_crash,
          color: CustomTheme().errorColor,
          size: 20,
        ),
        SizedBox(width: 5,),
        Text(
          chat!.lastMessage!.senderId != soulProfile_ViewModel.profileOverview!.profileData!.uId! ? chat!.profile.name  : "You have " + chat!.lastMessage!.message +" tourer request.",
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 12,
            color: ThemeColors().buttonColor,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: Text(
            chat!.lastMessage!.senderId != soulProfile_ViewModel.profileOverview!.profileData!.uId! ? " has " +chat!.lastMessage!.message+ " your tourer request." : "",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 12,
              color: CustomTheme().errorColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        )
      ],
    );
  }
  else if(chat!.lastMessage!.messageCode == "text" || chat!.lastMessage!.CDID == "#"){
    return Text(
        chat!.lastMessage!.message,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          color: ThemeColors().buttonColor,
          fontWeight: FontWeight.w100,
        ),
      );
  }
  }
}

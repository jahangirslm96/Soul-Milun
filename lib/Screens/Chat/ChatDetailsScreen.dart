import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ringtone_player/flutter_ringtone_player.dart';
import 'package:get/get.dart';
import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/chat.model.dart';
import 'package:soul_milan/Utils/CustomTheme.dart';
import 'package:soul_milan/Utils/Routes.dart';

import '../../Components/Headers/CustomHeader.dart';
import '../../Utils/Constants.dart';
import '../../Utils/ThemeColors.dart';

class ChatScreen2 extends StatefulWidget {
  const ChatScreen2({Key? key}) : super(key: key);

  @override
  State<ChatScreen2> createState() => _ChatScreen2State();
}

class _ChatScreen2State extends State<ChatScreen2> {
  final FocusNode _textFieldFocusNode = FocusNode();
  late TextEditingController _textFieldController;
  List<dynamic> chatStyle = [
    [
      0.0,
      0.0,
      Alignment.center,
      ThemeColors().soulColor,
      Colors.grey.shade200,
    ],
    [
      0.0,
      Get.width * .1,
      Alignment.centerRight,
      ThemeColors().labelTextColor,
      Colors.white,
    ],
    [
      Get.width * .1,
      0.0,
      Alignment.centerLeft,
      Colors.grey.shade200,
      Colors.black,
    ],
  ];

  bool isLoading = false;

  @override
  void initState() {
    _textFieldController = TextEditingController();

    channel.on("new-message1", (data) {
      if (chatPreview.id == data["chatID"]) {
        FlutterRingtonePlayer.play(
          android: AndroidSounds.notification,
          ios: IosSounds.glass,
          volume: 1, // Android only - API >= 28
        );
        setState(() {
          chatPreview.lastMessage = chatData.fromJson(data);
          chatPreview.chatDataList.insert(0, chatPreview.lastMessage);
        });
      }
      sortChat(data);
    });

    channel.on("status", (data) {});

    if (chatPreview.unreadMessage) {
      channel.emitWithAck("status", {
        "sendBy": userProfile.id.toString(),
        "chatID": chatPreview.id.toString(),
      }, ack: (data) {
        // data.map((e) {
        chatPreview.chatDataList
            .where((element) => element.status != 2 && element.type == 1)
            .forEach((element) {
          element.status = 2;
        });
        // }).toList();
        chatPreview.unreadMessage = false;
      });
    }

    setState(() {
      isLoading = chatPreview.chatDataList.isNotEmpty;
    });

    if (!isLoading) {
      loadChat();
    }
    super.initState();
  }

  sortChat(data) {
    var index = chatList.indexWhere((element) => element.id == data["chatID"]);
    if (index != -1) {
      chatList[index].lastMessage = chatData.fromJson(data);
      chatList[index].chatDataList.insert(0, chatList[index].lastMessage);
    } else {
      chatList.insert(0, chatList[index]);
      chatList.removeAt(index + 1);
    }
  }

  loadChat() {
    chatPreview.chatDataList.add(chatPreview.lastMessage);
    var response = connector.get("chat/messages/${chatPreview.id}");
    response.then((value) {
      if (value["success"] != null && value["success"]) {
        chatPreview.chatDataList =
            (value["chatData"]).map((e) => chatData.fromJson(e)).toList();
      }

      setState(() {
        isLoading = true;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Clear focus when tapping outside the text field
      onTap: () => _textFieldFocusNode.unfocus(),
      child: SafeArea(
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Get.width * 0.01,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(
                                    left: Get.width * 0.02,
                                    right: Get.width * 0.05),
                                child: GestureDetector(
                                  onTap: () => Get.toNamed("/chat"),
                                  child: Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 20,
                                    color: ThemeColors().iconColor,
                                  ),
                                ),
                              ),
                              Container(
                                width: Get.width * 0.1,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: CustomTheme().successColor,
                                    width: chatPreview.isOnline ? 3 : 0,
                                  ),
                                  image: DecorationImage(
                                    image: NetworkImage(
                                      connector.api.fileUrl +
                                          chatPreview.profile.profileImage,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          title: Text(
                            chatPreview.profile.name,
                            style: TextStyle(
                              fontSize: 18,
                              color: ThemeColors().buttonColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          subtitle: Text(
                            chatPreview.isOnline ? "Online" : "Offline",
                            style: TextStyle(
                              fontSize: 12,
                              color: ThemeColors().buttonColor,
                              fontWeight: FontWeight.w100,
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                splashRadius: 25,
                                icon: Icon(
                                  Icons.call,
                                  color: ThemeColors().buttonColor,
                                ),
                                onPressed: () {
                                  Get.toNamed(RoutesClass.voiceCallScreen);
                                },
                              ),
                              SizedBox(width: Get.width * 0.01),
                              IconButton(
                                splashRadius: 25,
                                icon: Icon(
                                  Icons.videocam_rounded,
                                  color: ThemeColors().buttonColor,
                                ),
                                onPressed: () {
                                  Get.toNamed(RoutesClass.videoCallScreen);
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          ThemeColors().containerOutlineColor,
                          Colors.transparent,
                        ],
                        stops: const [0.0, 0.5, 1.0],
                        begin: const FractionalOffset(0.0, 0.0),
                        end: const FractionalOffset(1.0, 0.0),
                        tileMode: TileMode.clamp,
                      ),
                    ),
                    child: Divider(
                      height: 0.5,
                      color: ThemeColors().containerOutlineColor,
                    ),
                  ),
                ],
              ),
              Expanded(
                child: Stack(children: <Widget>[
                  ListView.builder(
                    itemCount: chatPreview.chatDataList.length,
                    shrinkWrap: true,
                    reverse: true,
                    padding: const EdgeInsets.only(top: 10, bottom: 10),
                    itemBuilder: (context, i) {
                      var message = chatPreview.chatDataList[i];
                      return Padding(
                        padding: EdgeInsets.only(
                          right: chatStyle[message.type][0],
                          left: chatStyle[message.type][1],
                        ),
                        child: Container(
                            margin: EdgeInsets.symmetric(
                                vertical: Get.height * 0.01,
                                horizontal: Get.width * 0.03),
                            child: Align(
                                alignment: (chatStyle[message.type][2]),
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: (chatStyle[message.type][3]),
                                  ),
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        message.message,
                                        style: TextStyle(
                                          fontSize: 15,
                                          color: (chatStyle[message.type][4]),
                                        ),
                                      ),
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          SizedBox(width: Get.height * 0.02),
                                          Text(
                                            message.timeDifference_(),
                                            style: const TextStyle(
                                              fontSize: 8,
                                              color: Colors.grey,
                                            ),
                                          ),
                                          SizedBox(width: Get.width * 0.01),
                                          message.type == 1
                                              ? Icon(
                                                  message.status == 1
                                                      ? Icons.check_sharp
                                                      : Icons.done_all_sharp,
                                                  color: Colors.grey,
                                                  size: 12,
                                                )
                                              : Container()
                                        ],
                                      ),
                                    ],
                                  ),
                                ))),
                      );
                    },
                  ),
                  isLoading
                      ? Container()
                      : Center(
                          child: CircularProgressIndicator(
                            color: ThemeColors().buttonColor,
                          ),
                        ),
                ]),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    top: BorderSide(
                      color: ThemeColors().dividerColor,
                      width: 1,
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(vertical: Get.height * 0.01),
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: 25,
                      icon: Icon(
                        Icons.image,
                        color: ThemeColors().buttonColor,
                      ),
                      onPressed: () {},
                    ),
                    Expanded(
                      child: TextFormField(
                        focusNode: _textFieldFocusNode,
                        controller: _textFieldController,
                        cursorColor: ThemeColors().labelTextColor,
                        onChanged: onChange,
                        style: TextStyle(
                          color: ThemeColors().onBoardingHeadingColor,
                          fontSize: 15,
                        ),
                        decoration: InputDecoration(
                          isDense: true,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                              color: ThemeColors().enabledBorderColor,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(50.0),
                            borderSide: BorderSide(
                              width: 2,
                              color: ThemeColors().labelTextColor,
                            ),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: Get.height * 0.020,
                            horizontal: Get.width * 0.04,
                          ),
                          hintStyle: TextStyle(
                            color: ThemeColors().buttonColor,
                            fontSize: 15,
                          ),
                          hintText: "Message",
                          suffixIconConstraints:
                              const BoxConstraints(minWidth: 24, minHeight: 24),
                          suffixIcon: IconButton(
                            splashRadius: 20,
                            icon: Icon(
                              Icons.emoji_emotions_rounded,
                              color: ThemeColors().buttonColor,
                              size: 25,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      splashRadius: 25,
                      icon: Icon(
                        _textFieldController.text.isEmpty
                            ? Icons.mic
                            : Icons.send,
                        color: ThemeColors().buttonColor,
                        size: 30,
                      ),
                      onPressed: _textFieldController.text.isNotEmpty
                          ? sendMessage
                          : SendVoice,
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

  sendMessage() {
    Map<String, dynamic> body = {
      "chatID": chatPreview.id,
      "message": _textFieldController.text,
      "senderId": userProfile.id,
      "receiverId": chatPreview.profile.id,
      "status": 1,
    };
    _textFieldController.clear();

    channel.emitWithAck("send-message", body, ack: (data) {
      body["status"] = data["status"];
      chatPreview.lastMessage = chatData.fromJson(body);
      chatPreview.chatDataList.insert(0, chatPreview.lastMessage);
      // sortChat(data);
      setState(() {});
    });
  }

  SendVoice() {}

  onChange(value) {
    setState(() {});
  }
}

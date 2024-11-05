import 'dart:convert';

import 'customMessege.model.dart';
import 'package:timeago/timeago.dart' as timeago;

class CustomChatHead {
  String chatId;
  CustomMessege? lastMessage;
  ChatHeadProfileData profile;
  List<CustomMessege>? messages;
  bool unread;

  CustomChatHead({
    required this.chatId,
    required this.lastMessage,
    required this.profile,
    required this.unread,
    this.messages,
  });

  factory CustomChatHead.fromRawJson(String str) =>
      CustomChatHead.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomChatHead.fromJson(Map<String, dynamic> json) {
    return CustomChatHead(
      chatId: json["ChatID"],
      lastMessage: json["lastMessage"].length > 0
          ? CustomMessege.fromJson(json["lastMessage"][0])
          : null,
      profile: ChatHeadProfileData.fromJson(json["profile"]),
      messages: json["messages"],
      unread: json["unread"],
    );
  }

  Map<String, dynamic> toJson() => {
        "ChatID": chatId,
        "lastMessage": lastMessage?.toJson(),
        "unread": unread,
      };

  void updateMessageList(Map<String, dynamic> json) {
    List<dynamic> temp;
    messages = json["messages"] == null
        ? []
        : (json["messages"] as List<dynamic>)
            .map((messageJson) => CustomMessege.fromJson(messageJson))
            .toList();
  }

  initTempMessageList() {
    CustomMessege cm = CustomMessege(
        CDID: "",
        message: "",
        messageCode: "text",
        senderId: "",
        time: DateTime.now(),
        receiveTime: null,
        status: 0);
    messages = List<CustomMessege>.empty(growable: true);
    messages?.add(cm);
    return messages;
  }

  timeDifference_() {
    var days = DateTime.now().difference(lastMessage!.time).inDays;

    final now = DateTime.now();
    final pastDate = now.subtract(Duration(days: days));

    final formattedTime = timeago.format(pastDate, locale: 'en');
    return formattedTime; // Output: "30 minutes ago"
  }

  void sortMessages(List<CustomMessege>? messages) {
    messages?.sort((a, b) => b.time.compareTo(a.time));
  }
}

class ChatHeadProfileData {
  String uID;
  String name;
  String image;

  ChatHeadProfileData({
    required this.uID,
    required this.name,
    required this.image,
  });

  factory ChatHeadProfileData.fromJson(Map<String, dynamic> json) {
    return ChatHeadProfileData(
      uID: json["uID"],
      name: json["name"],
      image: json["image"],
    );
  }
}

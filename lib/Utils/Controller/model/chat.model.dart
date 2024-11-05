import 'package:soul_milan/Utils/Controller/constant.dart';
import 'package:soul_milan/Utils/Controller/model/profile.model.dart';

class ChatModel {
  final String id;
  final bool isOnline;

  final bool isTyping;
  bool unreadMessage;
  List<dynamic> chatDataList;

  final Profiles profile;
  chatData lastMessage;

  ChatModel(
      {required this.id,
      required this.profile,
      required this.lastMessage,
      required this.isOnline,
      required this.isTyping,
      required this.chatDataList,
      required this.unreadMessage});

  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      id: json["id"] ?? json["cid"] ?? json["ChatID"] ?? json["chatId"] ?? "",
      profile: Profiles.fromJson(json["profile"] ?? json["chatProfile"] ?? {}),
      isOnline: json["isOnline"] ?? false,
      isTyping: json["isTyping"] ?? false,
      chatDataList: json["chatList"] ?? [],
      lastMessage: chatData.fromJson(json["lastMessage"][0]),
      unreadMessage: json["unread"] ?? false,
    );
  }
}

class chatData {
  int type;
  final String message;
  final String time;
  int status;
  final bool isMedia;
  final int mediaType;
  final String mediaUrl;

  chatData(
      {required this.type,
      required this.message,
      required this.time,
      required this.status,
      required this.isMedia,
      required this.mediaType,
      required this.mediaUrl});

  factory chatData.fromJson(Map<String, dynamic> json) {
    return chatData(
      type: messageType(json["type"] ?? json["senderId"] ?? 0),
      message: json["message"] ?? "",
      time: json["time"] ?? json["messageTime"] ?? "",
      status: json["status"] ?? 0,
      isMedia: json["isMedia"] ?? false,
      mediaType: json["mediaType"] ?? 0,
      mediaUrl: json["mediaUrl"] ?? "",
    );
  }

  static messageType(value) {
    return value != 0
        ? value == userProfile.id
            ? 1
            : 2
        : 0;
  }

  timeDifference_() {
    if (time.isEmpty) return "";
    try {
      print(this.time);
      var time = DateTime.parse(this.time);
      var days = DateTime.now().difference(time).inDays;

      print(days);

      return days != 0
          ? days == 1
              ? "Yesterday"
              : "$days day ago"
          : time.hour > 12
              ? "${time.hour - 12}:${time.minute} AM"
              : "${time.hour}:${time.minute} PM";
    } catch (e) {
      return "Just Now";
    }
  }
}

import 'dart:convert';
import 'package:timeago/timeago.dart' as timeago;
import 'package:soul_milan/Utils/Controller/model/TourerInfo.model.dart';
import 'package:just_audio/just_audio.dart';

class CustomMessege {
  String CDID;
  String message;
  String? messageCode; //this is must to differentiate the message type
  String senderId;
  DateTime time;
  DateTime? receiveTime;
  int status;
  String? TOID; //this is tour booked popup id
  TourerInfo? tourerInfo;
  AudioPlayer? audioPlayer;

  CustomMessege({
    required this.CDID,
    required this.message,
    required this.messageCode,
    required this.senderId,
    required this.time,
    required this.receiveTime,
    required this.status,
    this.TOID,
    this.audioPlayer
  });

  factory CustomMessege.fromRawJson(String str) =>
      CustomMessege.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomMessege.fromJson(Map<String, dynamic> json) {
    List<String> voiceMessageData = json["message"].split('_');
    return CustomMessege(
      CDID: json["CDID"],
      message: json["message"],
      messageCode: json["messageCode"],
      senderId: json["senderId"],
      time: DateTime.parse(json["time"]),
      receiveTime: json["receiveTime"] != null
          ? DateTime.parse(json["receiveTime"])
          : null,
      status: json["Status"] ?? 0,
      TOID: json["TOID"],
      audioPlayer: voiceMessageData[0].toString() == "voice" ? AudioPlayer() : null
    );
  }

  Map<String, dynamic> toJson() => {
        "CDID": CDID,
        "message": message,
        "messageCode": messageCode,
        "senderId": senderId,
        "time": time.toIso8601String(),
        "receiveTime": receiveTime?.toIso8601String(),
        "Status": status,
        "TOID": TOID,
      };

  timeDifference_() {
    var days = DateTime.now().difference(time).inDays;

    final now = DateTime.now();
    final pastDate = now.subtract(Duration(days: days));

    final formattedTime = timeago.format(pastDate, locale: 'en');
    return formattedTime; // Output: "30 minutes ago"
  }
}

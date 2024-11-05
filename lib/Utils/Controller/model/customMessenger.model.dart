import 'dart:convert';
import 'customChatHead.model.dart';

class CustomMessenger {
  List<CustomChatHead>? chatHeads;

  CustomMessenger({
    this.chatHeads,
  });

  factory CustomMessenger.fromRawJson(String str) =>
      CustomMessenger.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory CustomMessenger.fromJson(Map<String, dynamic> json) {
    return CustomMessenger(
      chatHeads: (json['messenger'] as List<dynamic>?)
          ?.map((x) => CustomChatHead.fromJson(x))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "messenger":
            List<dynamic>.from(chatHeads?.map((x) => x.toJson()) ?? []),
  };

  void sortChatHeads() {
    chatHeads?.sort((a, b) => b.lastMessage!.time.compareTo(a.lastMessage!.time));
  }
}

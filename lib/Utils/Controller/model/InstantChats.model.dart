class InstantChats {
    String? icuid;
    int? chats;

    InstantChats({
        this.icuid,
        this.chats,
    });

    factory InstantChats.fromJson(Map<String, dynamic> json) => InstantChats(
        icuid: json["ICUID"],
        chats: json["chats"],
    );

    Map<String, dynamic> toJson() => {
        "ICUID": icuid,
        "chats": chats,
    };

}

import 'dart:convert';

//sample model
// {
//         "TOID": "4b221703",
//         "bookerUID": "2f9317b3",
//         "earnerUID": "13f3ad1b",
//         "bookingDate": "2023-11-10",
//         "bookingTime": "06:15",
//         "bookStatus": "accepted"
// }

class TourerInfo {
    String? toid;
    String? bookerUid;
    String? earnerUid;
    String? bookingDate;
    String? bookingTime;
    String? bookStatus;

    TourerInfo({
        this.toid,
        this.bookerUid,
        this.earnerUid,
        this.bookingDate,
        this.bookingTime,
        this.bookStatus,
    });

    factory TourerInfo.fromRawJson(String str) => TourerInfo.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TourerInfo.fromJson(Map<String, dynamic> json) => TourerInfo(
        toid: json["TOID"],
        bookerUid: json["bookerUID"],
        earnerUid: json["earnerUID"],
        bookingDate: json["bookingDate"],
        bookingTime: json["bookingTime"],
        bookStatus: json["bookStatus"] ?? null,
    );

    Map<String, dynamic> toJson() => {
        "TOID": toid,
        "bookerUID": bookerUid,
        "earnerUID": earnerUid,
        "bookingDate": bookingDate,
        "bookingTime": bookingTime,
        "bookStatus": bookStatus,
    };
}

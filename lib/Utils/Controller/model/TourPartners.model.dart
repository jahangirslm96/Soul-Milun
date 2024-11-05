//sample of this model
// {
//     "success": true,
//     "response": {
//         "males": [
//             {
//                 "eRID": "13f3ad1b",
//                 "uID": "c38558da",
//                 "rate": "250",
//                 "location": "Karachi",
//                 "responseTime": "6 - 8 Hours",
//                 "service": "1 Hour",
//                 "description": "asfasfasf",
//                 "name": "SaleemJani",
//                 "profilePicture": "e208cb04.jpg",
//                 "gender": 0,
//                 "age": 18
//             }
//         ],
//         "females": []
//     }
// }
//=======================

import 'dart:convert';

class TourPartners {
    TourTimeline? tourTimeline;

    TourPartners({
        this.tourTimeline,
    });

    // factory TourPartners.fromRawJson(String str) => TourPartners.fromJson(json.decode(str));

    // String toRawJson() => json.encode(toJson());

    factory TourPartners.fromJson(Map<String, dynamic> json) => TourPartners(
        tourTimeline: json["TourTimeline"] == null ? null : TourTimeline.fromJson(json["TourTimeline"]),
    );

    Map<String, dynamic> toJson() => {
        "TourTimeline": tourTimeline?.toJson(),
    };
}

class TourTimeline {
    List<TourProfile>? males;
    List<TourProfile>? females;

    TourTimeline({
        this.males,
        this.females,
    });

    factory TourTimeline.fromRawJson(String str) => TourTimeline.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TourTimeline.fromJson(Map<String, dynamic> json) => TourTimeline(
        males: json["males"] == null ? [] : List<TourProfile>.from(json["males"]!.map((x) => TourProfile.fromJson(x))),
        females: json["females"] == null ? [] : List<TourProfile>.from(json["females"]!.map((x) => TourProfile.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "males": males == null ? [] : List<dynamic>.from(males!.map((x) => x.toJson())),
        "females": females == null ? [] : List<dynamic>.from(females!.map((x) => x.toJson())),
    };
}

class TourProfile {
    String? eRid;
    String? uId;
    String? rate;
    String? location;
    String? responseTime;
    String? service;
    String? description;
    String? name;
    String? profilePicture;
    int? gender;
    int? age;

    TourProfile({
        this.eRid,
        this.uId,
        this.rate,
        this.location,
        this.responseTime,
        this.service,
        this.description,
        this.name,
        this.profilePicture,
        this.gender,
        this.age,
    });

    factory TourProfile.fromRawJson(String str) => TourProfile.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory TourProfile.fromJson(Map<String, dynamic> json) => TourProfile(
        eRid: json["eRID"],
        uId: json["uID"],
        rate: json["rate"],
        location: json["location"],
        responseTime: json["responseTime"],
        service: json["service"],
        description: json["description"],
        name: json["name"],
        profilePicture: json["profilePicture"],
        gender: json["gender"],
        age: json["age"],
    );

    Map<String, dynamic> toJson() => {
        "eRID": eRid,
        "uID": uId,
        "rate": rate,
        "location": location,
        "responseTime": responseTime,
        "service": service,
        "description": description,
        "name": name,
        "profilePicture": profilePicture,
        "gender": gender,
        "age": age,
    };
}

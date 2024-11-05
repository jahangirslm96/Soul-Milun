import 'dart:convert';

class EarnerProfile {
    EarnerData? earnerData;

    EarnerProfile({
        this.earnerData,
    });

    factory EarnerProfile.fromRawJson(String str) => EarnerProfile.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EarnerProfile.fromJson(Map<String, dynamic> json) { 
      return EarnerProfile(
        earnerData: json["EarnerData"] == null ? null : EarnerData.fromJson(json["EarnerData"]),
    );
    }

    Map<String, dynamic> toJson() => {
        "EarnerData": earnerData?.toJson(),
    };
}

class EarnerData {
    String? erid;
    String? uId;
    String? ratePerHour;
    String? location;
    String? city;
    String? responseTime;
    String? minimumServiceTime;
    String? description;

    EarnerData({
        this.erid,
        this.uId,
        this.ratePerHour,
        this.location,
        this.city,
        this.responseTime,
        this.minimumServiceTime,
        this.description,
    });

    factory EarnerData.fromRawJson(String str) => EarnerData.fromJson(json.decode(str));

    String toRawJson() => json.encode(toJson());

    factory EarnerData.fromJson(Map<String, dynamic> json) { 
      return EarnerData(
        erid: json["ERID"],
        uId: json["uID"],
        ratePerHour: json["ratePerHour"],
        location: json["location"],
        city: json["city"],
        responseTime: json["responseTime"],
        minimumServiceTime: json["minimumServiceTime"],
        description: json["description"],
    );
    }
    Map<String, dynamic> toJson() => {
        "ERID": erid,
        "uID": uId,
        "ratePerHour": ratePerHour,
        "location": location,
        "city": city,
        "responseTime": responseTime,
        "minimumServiceTime": minimumServiceTime,
        "description": description,
    };
}

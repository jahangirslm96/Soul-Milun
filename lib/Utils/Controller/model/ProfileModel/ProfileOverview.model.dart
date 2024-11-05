import 'package:meta/meta.dart';
import 'dart:convert';

class ProfileOverview {
  ProfileData? profileData;
  Map<String, dynamic>? interest;
  Map<String, dynamic>? similarInterest;

  ProfileOverview({
    this.profileData,
    this.interest,
    this.similarInterest,
  });

  factory ProfileOverview.fromRawJson(String str) =>
      ProfileOverview.fromJson(json.decode(str));

  factory ProfileOverview.fromJson(Map<String, dynamic> json) {
    return ProfileOverview(
      profileData: ProfileData.fromJson(json["profileData"] ?? json),
      interest: json["interest"],
      similarInterest: json["similarInterest"],
    );
  }

  getSelectedInterest() {
    Map<String, List<String>> selectedInterest = {};
    interest!.forEach((category, items) {
      // Initialize the list for the category if it doesn't exist
      selectedInterest[category] ??= [];

      // Iterate over the items within each category
      items.forEach((item) {
        // Add the interest name to the list
        selectedInterest[category]?.add(item["interest"]);
      });
    });
    return selectedInterest;
  }

}


class ProfileData {
  String? uId;
  String? name;
  int? age;
  String? city;
  String? bio;
  String? tagline;
  String? height;
  List<String>? education;
  String? profession;
  List<String>? pictures;
  String? profilePicture;
  String? religion;
  String? maritalStatus;
  String? gender;
  String? match;
  String? distance;
  String? profileType;

  ProfileData({
    this.uId,
    this.name,
    this.age,
    this.city,
    this.bio,
    this.tagline,
    this.height,
    this.education,
    this.profession,
    this.pictures,
    this.gender,
    this.profilePicture,
    this.maritalStatus,
    this.religion,
    this.match,
    this.distance,
    this.profileType,
  });

  factory ProfileData.fromRawJson(String str) =>
      ProfileData.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());
  factory ProfileData.fromJson(Map<String, dynamic> json) => ProfileData(
        uId: json["uID"],
        name: json["name"],
        age: json["age"],
        city: json["city"],
        bio: json["bio"],
        tagline: json["tagline"],
        height: json["height"],
        education: (json['education'] == null ? [] : json['education'] as List<dynamic>).cast<String>(),
        profession: json["profession"],
        pictures: json["pictures"] != null ? List<String>.from(jsonDecode(json["pictures"])) : null,//json["pictures"] != null ? List<String>.from(json["pictures"].map((x) => x)) : null,
        profilePicture: json["profilePicture"],
        religion: json["religion"],
        maritalStatus: json['maritalStatus'],
        gender: json["gender"],
        match: json['match'],
        distance: json["distance"],
        profileType: json["profileType"]
      );

  Map<String, dynamic> toJson() => {
        "uID": uId,
        "name": name,
        "age": age,
        "city": city,
        "bio": bio,
        "tagline": tagline,
        "height": height,
        "education": education,
        "profession": profession,
        "pictures": List<dynamic>.from(pictures!.map((x) => x)),
        "gender": gender,
        "maritalStatus": maritalStatus,
        "match": match,
        "distance": distance,
        "profileType" : profileType
      };

  about() {
    var he = height.toString().replaceFirst(".", "'");
    return [
      "Age: $age",
      "Profession: $profession",
      "Height: $he''",
      "City: $city",
      "Gender: $gender",
    ];
  }
}

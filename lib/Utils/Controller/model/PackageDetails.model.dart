import 'dart:convert';

class PackageDetails {
  String? pid;
  String? uid;
  String? package;
  List<String>? given;
  String? packagePic;
  int? paid;
  String? startingDate;
  String? endingDate;
  String? newInstantChat;
  PackageType? currentPackageType = PackageType.NONE;
  int? freeChats = 0;

  PackageDetails({
    this.pid,
    this.uid,
    this.package,
    this.given,
    this.packagePic,
    this.paid,
    this.startingDate,
    this.endingDate,
    this.newInstantChat,
    this.currentPackageType,
    this.freeChats,
  });

  factory PackageDetails.fromRawJson(String str) =>
      PackageDetails.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PackageDetails.fromJson(Map<String, dynamic> json) {
    return  PackageDetails(
        pid: json["PID"],
        uid: json["UID"],
        package: json["package"],
        given: json["given"] == null
            ? []
            : List<String>.from(jsonDecode(json["given"])),//List<String>.from(json["given"]!.map((x) => x)),
        packagePic: json["packagePic"],
        paid: json["paid"],
        startingDate: json["startingDate"],
        endingDate: json["endingDate"],
        newInstantChat: json["newInstantChat"],
        currentPackageType: getPackageFromString(json["package"]),
        freeChats: json["freeChats"],
      );
  }

  Map<String, dynamic> toJson() => {
        "PID": pid,
        "UID": uid,
        "package": package,
        "given": given == null ? [] : List<dynamic>.from(given!.map((x) => x)),
        "packagePic": packagePic,
        "paid": paid,
        "startingDate": startingDate,
        "endingDate": endingDate,
        "newInstantChat": newInstantChat,
        "freeChats": freeChats
      };

    bool isSubscriptionActive() {
    if (endingDate == null) {
      return false; // Handle case where endingDate is not available
    }

    DateTime expiryDate = DateTime.parse(endingDate!);
    DateTime currentDate = DateTime.now();

    return expiryDate.isAfter(currentDate);
  }
}

PackageType getPackageFromString(String packageString) {
  switch (packageString) {
    case "BASIC":
      return PackageType.BASIC;
    case "SILVER":
      return PackageType.SILVER;
    case "GOLD":
      return PackageType.GOLD;
    case "PLATINIUM":
      return PackageType.PLATINIUM;
    default:
      return PackageType.NONE;
  }
}

enum PackageType { BASIC, SILVER, GOLD, PLATINIUM, NONE }
